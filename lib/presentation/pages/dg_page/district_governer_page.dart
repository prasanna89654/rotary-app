import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rotary/core/resources/app_strings.dart';
import 'package:rotary/core/resources/app_styles.dart';
import 'package:rotary/presentation/features/district_governor_bloc/district_governor_bloc.dart';
import 'package:rotary/presentation/pages/dg_page/district_governor_detail_page.dart';

import '../../common_widgets/common_error_widget.dart';

class DistrictGovernerPage extends StatelessWidget {
  const DistrictGovernerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => BlocProvider.of<DistrictGovernorBloc>(context).add(
        GetAllDistrictGovernors(),
      ),
      child: BlocBuilder<DistrictGovernorBloc, DistrictGovernorState>(
        builder: (context, state) {
          if (state is DistrictGovernorLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is DistrictGovernorError) {
            return CommonErrorWidget(
              message: state.error,
            );
          }
          if (state is DistrictGovernorLoaded)
            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DistrictGovernorDetailPage(
                          image: state
                              .districtGovernorResponseModel!.active.image
                              .toString(),
                          activeYear: state
                              .districtGovernorResponseModel!.active.activeYear
                              .toString(),
                          name: state.districtGovernorResponseModel!.active.name
                              .toString(),
                          id: state.districtGovernorResponseModel!.active.id
                              .toString(),
                          email: state.districtGovernorResponseModel!.active
                                  .email ??
                              "",
                          club: state
                                  .districtGovernorResponseModel!.active.club ??
                              "",
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    height: 120,
                    width: double.infinity,
                    color: Color(0xffECD058),
                    child: Row(
                      children: [
                        Hero(
                          tag: state.districtGovernorResponseModel!.active.name
                              .toString(),
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: AppColors.rotaryGold,
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(state
                                    .districtGovernorResponseModel!.active.image
                                    .toString()),
                                fit: BoxFit.cover,
                              ),
                              border: Border.all(
                                color: Colors.white,
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AutoSizeText(
                              state.districtGovernorResponseModel!.active.name
                                  .toString(),
                              style: AppStyles.kBB14,
                            ),
                            SizedBox(height: 3),
                            AutoSizeText(
                              "District Governor - " +
                                  "(" +
                                  state.districtGovernorResponseModel!.active
                                      .activeYear
                                      .toString() +
                                  ")",
                              style: AppStyles.kB12,
                            ),
                            AutoSizeText(
                              "Rotary Club of " +
                                  state.districtGovernorResponseModel!.active
                                      .club
                                      .toString(),
                              style: AppStyles.kB12,
                            ),
                            SizedBox(height: 3),
                            AutoSizeText(
                              state.districtGovernorResponseModel!.active.email
                                  .toString(),
                              style: AppStyles.kB12.copyWith(
                                color: AppColors.rotaryBlue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount:
                        state.districtGovernorResponseModel!.other.length,
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.1,
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DistrictGovernorDetailPage(
                                image: state.districtGovernorResponseModel!
                                        .other[index].image ??
                                    "",
                                activeYear: state.districtGovernorResponseModel!
                                        .other[index].activeYear ??
                                    "",
                                name: state.districtGovernorResponseModel!
                                        .other[index].name ??
                                    "",
                                id: state.districtGovernorResponseModel!
                                        .other[index].id ??
                                    "",
                                email: state.districtGovernorResponseModel!
                                        .other[index].email ??
                                    "",
                                club: state.districtGovernorResponseModel!
                                        .other[index].club ??
                                    "",
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          // color: Colors.white,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Column(children: [
                            Hero(
                              tag: state.districtGovernorResponseModel!
                                  .other[index].name
                                  .toString(),
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: AppColors.rotaryGold,
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(state
                                          .districtGovernorResponseModel!
                                          .other[index]
                                          .image
                                          .toString()),
                                      fit: BoxFit.cover,
                                    ),
                                    shape: BoxShape.circle),
                              ),
                            ),
                            SizedBox(height: 10),
                            AutoSizeText(
                                state.districtGovernorResponseModel!
                                    .other[index].name
                                    .toString(),
                                style: AppStyles.kBB12,
                                minFontSize: 10,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                            AutoSizeText(
                              "District Governor - " +
                                  "(" +
                                  state.districtGovernorResponseModel!
                                      .other[index].activeYear
                                      .toString() +
                                  ")",
                              style: AppStyles.kB10,
                              textAlign: TextAlign.center,
                              minFontSize: 8,
                            ),
                            AutoSizeText(
                              "Rotary Club of " +
                                  state.districtGovernorResponseModel!
                                      .other[index].club
                                      .toString(),
                              style: AppStyles.kB10,
                              minFontSize: 8,
                              maxLines: 1,
                            ),
                          ]),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          return Container();
        },
      ),
    );
  }
}
