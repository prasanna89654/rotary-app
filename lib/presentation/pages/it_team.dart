import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rotary/core/resources/app_strings.dart';
import 'package:rotary/data/models/district_committee/district_committee_model.dart';
import 'package:rotary/presentation/features/district_committee_bloc/districtcommittee_bloc.dart';

import '../../core/resources/app_styles.dart';

class ITTeamPage extends StatefulWidget {
  const ITTeamPage({Key? key}) : super(key: key);

  @override
  State<ITTeamPage> createState() => _ITTeamPageState();
}

class _ITTeamPageState extends State<ITTeamPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<DistrictcommitteeBloc>(context)
        .add(GetAllDistrictCommitteesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      appBar: AppBar(
        title: Text('IT Team'),
      ),
      body: BlocConsumer<DistrictcommitteeBloc, DistrictcommitteeState>(
        listener: (context, state) {},
        builder: (context, state) {
          DistrictCommitteeModel? dcm;
          if (state is DistrictcommitteeLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is DistrictcommitteeLoadedState) {
            int? index = state.districtCommitteeList.councils?.indexWhere(
                (element) =>
                    element.councilName ==
                    'District Information Technology Committee');

            /// check for dcm is null and assign it to dcm if not null

            index == null
                ? dcm = null
                : dcm = state.districtCommitteeList.councils?.elementAt(index);

            /// sort the list according to position in the list
            if (dcm != null) {
              dcm.members?.sort((a, b) => a.position!.compareTo(b.position!));
            }

            // print(value);

            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: SizedBox(
                      height: 70,
                      width: double.infinity,
                      child: Stack(children: [
                        Positioned(
                          top: 0,
                          left: 30,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.only(left: 50, right: 50),
                            height: 70,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: AutoSizeText(dcm?.name ?? '',
                                              // allList[index].councilName ?? "",
                                              // "",
                                              style: AppStyles.kBB14,
                                              maxLines: 2,
                                              minFontSize: 6),
                                        ),
                                        AutoSizeText(
                                          dcm?.position ?? '',
                                          // allList[index].name ?? "",
                                          // "",
                                          style: AppStyles.kB12,
                                        ),
                                        AutoSizeText(
                                          // allList[index].position ?? "",
                                          "",
                                          style: AppStyles.kB12,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey,
                              image: dcm?.image == null
                                  ? null
                                  : DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        dcm?.image ?? "",
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(20),
                      itemCount: dcm?.members?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: SizedBox(
                            height: 70,
                            width: double.infinity,
                            child: Stack(children: [
                              Positioned(
                                top: 0,
                                left: 30,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 50, right: 50),
                                  height: 70,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                child: AutoSizeText(
                                                    dcm?.members?[index].name ??
                                                        '',
                                                    // allList[index].councilName ?? "",
                                                    // "",
                                                    style: AppStyles.kBB14,
                                                    maxLines: 2,
                                                    minFontSize: 6),
                                              ),
                                              AutoSizeText(
                                                dcm?.members?[index].position ??
                                                    '',
                                                // allList[index].name ?? "",
                                                // "",
                                                style: AppStyles.kB12,
                                              ),
                                              AutoSizeText(
                                                // allList[index].position ?? "",
                                                "",
                                                style: AppStyles.kB12,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey,
                                    image: dcm?.members?[index].image == null
                                        ? null
                                        : DecorationImage(
                                            image: CachedNetworkImageProvider(
                                                dcm?.members?[index].image ??
                                                    ""),
                                          ),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        );
                      }),
                ],
              ),
            );
          }
          return Center(
            child: Text("Error"),
          );
        },
      ),
    );
  }
}
