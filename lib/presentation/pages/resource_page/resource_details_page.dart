import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rotary/core/injection/injection_container.dart';
import 'package:rotary/core/resources/app_strings.dart';
import 'package:rotary/core/resources/app_styles.dart';
import 'package:rotary/presentation/features/resources_bloc/resources_bloc.dart';
import 'package:rotary/presentation/pages/resource_page/resource_description_page.dart';
import 'package:url_launcher/url_launcher.dart';

class ResourcesDetailPage extends StatefulWidget {
  final String id;
  const ResourcesDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<ResourcesDetailPage> createState() => _ResourcesDetailPageState();
}

class _ResourcesDetailPageState extends State<ResourcesDetailPage> {
  ResourcesBloc resourcesBloc = ResourcesBloc(
    di(),
    di(),
    di(),
  );
  @override
  void initState() {
    super.initState();
    resourcesBloc.add(GetResourcesDetailsEvent(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      appBar: AppBar(
        title: Text('Resources'),
      ),
      body: BlocBuilder<ResourcesBloc, ResourcesState>(
        bloc: resourcesBloc,
        builder: (context, state) {
          if (state is ResourcesLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ResourcesErrorState) {
            return Center(
              child: Text(state.error),
            );
          }
          if (state is ResourcesDetailLoadedState) {
            // log(state.resourcesDetail?.resources ?? 'null');
            return Column(
              children: [
                Container(
                  alignment: Alignment.bottomLeft,
                  // padding: const EdgeInsets.all(10),
                  // height: 200,
                  // width: double.infinity,
                  decoration: BoxDecoration(),
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Container(
                        width: double.infinity,
                        child: CachedNetworkImage(
                          filterQuality: FilterQuality.medium,
                          imageUrl: state.resourcesDetail?.info?.image ?? '',
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          color: Colors.grey.withOpacity(0.4),
                          colorBlendMode: BlendMode.multiply,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                  color: Colors.pink,
                                ),
                                child: Text(
                                  state.resourcesDetail?.info?.count
                                          .toString() ??
                                      "",
                                  // state.resourcesList[index].count.toString(),
                                  style: AppStyles.kWB14,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                state.resourcesDetail?.info?.title ?? "",
                                // state.resourcesList[index].count.toString(),
                                style: AppStyles.kWB14,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    // separatorBuilder: (context, index) => SizedBox(height: 10,),
                    itemCount: state.resourcesDetail?.resources?.length ?? 0,
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: () async {
                          if (state.resourcesDetail?.resources![index]
                                  .isDownloadable ==
                              1) {
                            bool canLaunch = await canLaunchUrl(Uri.parse(state
                                    .resourcesDetail
                                    ?.resources?[index]
                                    .downloadUrl ??
                                ""));
                            if (canLaunch) {
                              await launchUrl(
                                  Uri.parse(state.resourcesDetail
                                          ?.resources?[index].downloadUrl ??
                                      ""),
                                  mode: Platform.isAndroid
                                      ? LaunchMode.externalNonBrowserApplication
                                      : LaunchMode.platformDefault);
                            } else {
                              throw 'Could not launch ${state.resourcesDetail?.resources?[index].downloadUrl ?? ""}';
                            }
                          } else if (state.resourcesDetail?.resources![index]
                                  .isExternal ==
                              1) {
                            bool canLaunch = await canLaunchUrl(
                              Uri.parse(state.resourcesDetail?.resources?[index]
                                      .externalLink ??
                                  ""),
                            );
                            if (canLaunch) {
                              await launchUrl(
                                  Uri.parse(state.resourcesDetail
                                          ?.resources?[index].externalLink ??
                                      ""),
                                  mode: Platform.isAndroid
                                      ? LaunchMode.externalNonBrowserApplication
                                      : LaunchMode.platformDefault);
                            } else {
                              throw 'Could not launch ${state.resourcesDetail?.resources?[index].downloadUrl ?? ""}';
                            }

                            /// this condition gets called when the resource has some description to show in the next page.
                          } else if (state.resourcesDetail?.resources![index]
                                      .isDownloadable ==
                                  0 &&
                              state.resourcesDetail?.resources![index]
                                      .isExternal ==
                                  0) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResourceDescriptionPage(
                                  id: state.resourcesDetail?.resources?[index]
                                          .id ??
                                      "",
                                  name: state.resourcesDetail?.resources?[index]
                                          .title ??
                                      "",
                                ),
                              ),
                            );
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          width: double.infinity,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        state.resourcesDetail?.resources![index]
                                                .title ??
                                            "",
                                        style: AppStyles.kBB10,
                                      ),
                                    ),
                                    // Flexible(
                                    //   child: Text(
                                    //     state.resourcesDetail.resources![index]
                                    //                 .isDownloadable ==
                                    //             1
                                    //         ? "Open PDF"
                                    //         : state
                                    //                     .resourcesDetail
                                    //                     .resources![index]
                                    //                     .isExternal ==
                                    //                 1
                                    //             ? "Link to url"
                                    //             : "Show more details",
                                    //     style: AppStyles.kB10,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              state.resourcesDetail?.resources![index]
                                          .isDownloadable ==
                                      1
                                  ? Container(
                                      alignment: Alignment.center,
                                      width: 40,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: AppColors.appBackgroundColor,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // Text(
                                          //   "PDF",
                                          //   style: TextStyle(
                                          //       color: Colors.black54,
                                          //       fontSize: 12),
                                          // ),
                                          Icon(
                                            Icons.file_download,
                                            color: Colors.black54,
                                            size: 15,
                                          ),
                                        ],
                                      ),
                                    )
                                  : SizedBox(),
                              state.resourcesDetail?.resources![index]
                                          .isExternal ==
                                      1
                                  ? Image.asset("assets/images/link.png")
                                  : SizedBox(),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                )
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
