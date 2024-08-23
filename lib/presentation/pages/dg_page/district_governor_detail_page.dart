import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rotary/core/injection/injection_container.dart';
import 'package:rotary/core/resources/app_strings.dart';
import 'package:rotary/core/resources/app_styles.dart';
import 'package:rotary/data/models/district_governors/district_governor_detail_model/district_governor_detail_model..dart';
import 'package:rotary/presentation/features/district_governor_bloc/district_governor_bloc.dart';

class DistrictGovernorDetailPage extends StatefulWidget {
  final String image;
  final String name;
  final String activeYear;
  final String id;
  final String email;
  final String club;
  const DistrictGovernorDetailPage({
    Key? key,
    required this.image,
    required this.name,
    required this.activeYear,
    required this.id,
    required this.email,
    required this.club,
  }) : super(key: key);

  @override
  State<DistrictGovernorDetailPage> createState() =>
      _DistrictGovernorDetailPageState();
}

class _DistrictGovernorDetailPageState
    extends State<DistrictGovernorDetailPage> {
  DistrictGovernorBloc _districtGovernorBloc = DistrictGovernorBloc(di(), di());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      appBar: AppBar(
        title: Text("District Governor Detail"),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            height: 120,
            width: double.infinity,
            color: Color(0xffECD058),
            child: Row(
              children: [
                Hero(
                  tag: widget.name,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.rotaryGold,
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(widget.image),
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
                      widget.name,
                      style: AppStyles.kBB14,
                    ),
                    SizedBox(height: 3),
                    AutoSizeText(
                      "District Governor - " +
                          "(" +
                          widget.activeYear.toString() +
                          ")",
                      style: AppStyles.kB12,
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    AutoSizeText(
                      "Rotary Club of " + widget.club,
                      style: AppStyles.kB12,
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    AutoSizeText(
                      widget.email,
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
          Expanded(
            child: BlocBuilder<DistrictGovernorBloc, DistrictGovernorState>(
              bloc: _districtGovernorBloc
                ..add(GetDistrictGovernorDetail(widget.id)),
              builder: (context, state) {
                if (state is DistrictGovernorLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is DistrictGovernorError) {
                  return Center(child: Text(state.error));
                }
                if (state is DistrictGovernorLoaded) {
                  DistrictGovernorDetailModel dgDetail =
                      state.districtGovernorDetailModel!;
                  return SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                "Biodata of District Governor",
                                style: AppStyles.kBB14,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      dgDetail.info?.description ?? "",
                                      style: AppStyles.kB12,
                                      textAlign: TextAlign.justify,
                                    ),
                                    // dgDetail.history != null
                                    //     ? Column(
                                    //         crossAxisAlignment:
                                    //             CrossAxisAlignment.start,
                                    //         children: [
                                    //           Padding(
                                    //             padding:
                                    //                 const EdgeInsets.symmetric(
                                    //                     vertical: 10),
                                    //             child: Text(
                                    //               "Rotary Involvement",
                                    //               style: AppStyles.kBB12,
                                    //             ),
                                    //           ),
                                    //           // ignore: unused_local_variable
                                    //           for (var i in dgDetail.history!)
                                    //             Wrap(
                                    //               children: [
                                    //                 Text(
                                    //                   "${i.year ?? ""}",
                                    //                   style: AppStyles.kB12,
                                    //                 ),
                                    //                 i.position == null ||
                                    //                         i.position == ""
                                    //                     ? SizedBox()
                                    //                     : Text(
                                    //                         ", ${i.position}",
                                    //                         style:
                                    //                             AppStyles.kB12,
                                    //                       ),
                                    //                 i.name == null ||
                                    //                         i.name == ""
                                    //                     ? SizedBox()
                                    //                     : Text(
                                    //                         ", ${i.name}",
                                    //                         style:
                                    //                             AppStyles.kB12,
                                    //                       )
                                    //               ],
                                    //             ),
                                    //         ],
                                    //       )
                                    //     : SizedBox(),
                                  ],
                                ),
                              ),
                              dgDetail.dgMessage != null
                                  ? Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 16),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              AutoSizeText(
                                                "Message from DG - " +
                                                    "${dgDetail.dgMessage?.month?.toUpperCase() ?? ""}" +
                                                    " ${dgDetail.dgMessage?.year ?? ""}",
                                                style: AppStyles.kBB14,
                                              ),
                                              Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color: Color(0xff192039),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Colors.white,
                                                  size: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        dgDetail.dgMessage?.message != null &&
                                                dgDetail.dgMessage?.message !=
                                                    ""
                                            ? Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  dgDetail.dgMessage?.message ??
                                                      "",
                                                  style: AppStyles.kB12,
                                                ),
                                              )
                                            : SizedBox(),
                                      ],
                                    )
                                  : SizedBox(),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
