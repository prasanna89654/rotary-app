import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rotary/core/resources/app_styles.dart';
import 'package:rotary/data/models/resources/resources_model.dart';
import 'package:rotary/presentation/features/resources_bloc/resources_bloc.dart';
import 'package:rotary/presentation/pages/resource_page/resource_details_page.dart';

import '../../common_widgets/common_error_widget.dart';

class ResourcesPage extends StatelessWidget {
  ResourcesPage({Key? key}) : super(key: key);
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => BlocProvider.of<ResourcesBloc>(context).add(
        GetAllResourcesEvent(),
      ),
      child: BlocBuilder<ResourcesBloc, ResourcesState>(
        builder: (context, state) {
          if (state is ResourcesLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ResourcesErrorState) {
            return CommonErrorWidget(message: state.error);
          }
          if (state is ResourcesDetailLoadedState) {
            int topResourceIndex = state.resourcesList!.indexWhere(
                (element) => element.name == "Rotary District 3292 Resources");

            List<ResourcesModel> resourcesList = state.resourcesList ?? [];
            ResourcesModel topResource = resourcesList[topResourceIndex];
            resourcesList.removeAt(topResourceIndex);

            resourcesList.insert(resourcesList.length, topResource);
            return SingleChildScrollView(
              controller: scrollController,
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResourcesDetailPage(
                            id: topResource.id ?? "",
                          ),
                        ),
                      );
                    },
                    child: Container(
                        alignment: Alignment.bottomLeft,
                        width: double.infinity,
                        child: Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            Container(
                              width: double.infinity,
                              child: CachedNetworkImage(
                                filterQuality: FilterQuality.medium,
                                imageUrl: topResource.image.toString(),
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
                                padding: const EdgeInsets.all(10),
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
                                        topResource.count.toString(),
                                        style: AppStyles.kWB14,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      topResource.name.toString(),
                                      style: AppStyles.kWB14,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                  GridView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    shrinkWrap: true,
                    itemCount: state.resourcesList?.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.4,
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemBuilder: (context, index) {
                      if (index == state.resourcesList!.length - 1) {
                        return Container();
                      }
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResourcesDetailPage(
                                id: state.resourcesList![index].id!,
                              ),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                alignment: Alignment.bottomLeft,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      state.resourcesList![index].image
                                          .toString(),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
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
                                        state.resourcesList![index].count
                                            .toString(),
                                        style: AppStyles.kWB14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5, left: 5),
                              child: AutoSizeText(
                                state.resourcesList![index].name.toString(),
                                style: AppStyles.kBB14,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
