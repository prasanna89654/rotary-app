import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:rotary/core/resources/app_strings.dart';
import 'package:rotary/core/resources/app_styles.dart';
import 'package:rotary/data/models/district_committee/district_committee_model.dart';
import 'package:rotary/presentation/common_widgets/common_error_widget.dart';
import 'package:rotary/presentation/common_widgets/custom_textfield.dart';
import 'package:rotary/presentation/features/district_committee_bloc/districtcommittee_bloc.dart';

class DistrictComitteePage extends StatefulWidget {
  DistrictComitteePage({Key? key}) : super(key: key);

  @override
  State<DistrictComitteePage> createState() => _DistrictComitteePageState();
}

class _DistrictComitteePageState extends State<DistrictComitteePage> {
  final ScrollController _scrollController = ScrollController();
  String advFilter = "";
  double initialButtonPosition = 30;
  Offset initialButtonPositionOffset = Offset(10, 30);
  int selectedItem = -1;
  double containerHeight = 0;
  // bool isDetail = false;
  // bool buildUI = false;
  late StreamSubscription<bool> keyboardSubscription;
  List<DistrictCommitteeModel> allList = [];

  @override
  void initState() {
    super.initState();
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      print('Keyboard visibility update. Is visible: $visible');
      if (!visible) {
        FocusScope.of(context).requestFocus(FocusNode());
      }
    });
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async =>
          BlocProvider.of<DistrictcommitteeBloc>(context).add(
        GetAllDistrictCommitteesEvent(),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    hintText: "Search by committee name ...",
                    onChanged: (value) {
                      print(value);
                      BlocProvider.of<DistrictcommitteeBloc>(context)
                          .add(SearchCommitteeEvent(searchText: value));
                    },
                  ),
                ),
                SizedBox(width: 30),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(builder: (context, setstate) {
                            return AlertDialog(
                              title: Text("Sort by"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setstate(() {
                                        setState(() {
                                          advFilter = "asc";
                                        });
                                      });
                                      BlocProvider.of<DistrictcommitteeBloc>(
                                              context)
                                          .add(SortCommitteeEvent(
                                              ascOrDesc: advFilter));
                                      Navigator.pop(context);
                                    },
                                    child: Row(
                                      children: [
                                        advFilter == "asc"
                                            ? Icon(Icons.check_box)
                                            : Icon(
                                                Icons.check_box_outline_blank),
                                        // Checkbox(value: true, onChanged: (value) {}),
                                        Text("Ascending"),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setstate(() {
                                        setState(() {
                                          advFilter = "desc";
                                        });
                                      });
                                      BlocProvider.of<DistrictcommitteeBloc>(
                                              context)
                                          .add(SortCommitteeEvent(
                                              ascOrDesc: advFilter));
                                      Navigator.pop(context);
                                    },
                                    child: Row(
                                      children: [
                                        advFilter == "desc"
                                            ? Icon(Icons.check_box)
                                            : Icon(
                                                Icons.check_box_outline_blank),
                                        // Checkbox(value: true, onChanged: (value) {}),
                                        Text("Descending"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                        });
                  },
                  child: Icon(
                    Icons.settings,
                    color: Color(0xff919191),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocConsumer<DistrictcommitteeBloc, DistrictcommitteeState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is DistrictcommitteeLoadedState) {
                  // allList = [];
                  // setState(() {

                  // });
                  allList = state.districtCommitteeList.councils!;
                  if (state.districtCommitteeList.main != null &&
                      allList[0].isMain == false) {
                    allList.insert(0, state.districtCommitteeList.main!);
                  }
                }
                if (state is DistrictComitteeSearchLoaded) {
                  allList = state.districtCommitteeList.councils!;
                  // allList.add(state.districtCommitteeList.main!);
                }
                if (state is DistrictcommitteeLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is DistrictcommitteeErrorState) {
                  return CommonErrorWidget(message: state.error);
                }
                if (state is DistrictcommitteeLoadedState ||
                    state is DistrictComitteeSearchLoaded) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      controller: _scrollController,
                      child: ListView.builder(
                        controller: _scrollController,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: allList.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
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
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.white,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Flexible(
                                                      child: AutoSizeText(
                                                          allList[index]
                                                                  .councilName ??
                                                              "",
                                                          style:
                                                              AppStyles.kBB14,
                                                          maxLines: 2,
                                                          minFontSize: 6),
                                                    ),
                                                    AutoSizeText(
                                                      allList[index].name ?? "",
                                                      style: AppStyles.kB12,
                                                    ),
                                                    AutoSizeText(
                                                      allList[index].position ??
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
                                          image: allList[index].image == null
                                              ? null
                                              : DecorationImage(
                                                  image:
                                                      CachedNetworkImageProvider(
                                                    allList[index].image ?? "",
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: AnimatedContainer(
                                    curve: Curves.easeInOutSine,
                                    onEnd: () {
                                      // if (isDetail) {
                                      //   // setState(() {
                                      //     buildUI = true;
                                      //   // });
                                      // }
                                    },
                                    duration: Duration(milliseconds: 200),
                                    height: index == selectedItem
                                        ? containerHeight
                                        : 0,
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white,
                                    ),
                                    child: index == selectedItem
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                allList[index].councilName ??
                                                    "",
                                                style: AppStyles.kBB14,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              SizedBox(
                                                height: 70,
                                                child: Stack(
                                                  children: [
                                                    Positioned(
                                                      top: 0,
                                                      left: 20,
                                                      right: 0,
                                                      child: Container(
                                                        height: 70,
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          color: AppColors
                                                              .appBackgroundColor,
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 50),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              AutoSizeText(
                                                                allList[index]
                                                                        .name ??
                                                                    "",
                                                                style: AppStyles
                                                                    .kBB14,
                                                                maxLines: 1,
                                                              ),
                                                              AutoSizeText(
                                                                allList[index]
                                                                        .position ??
                                                                    "",
                                                                style: AppStyles
                                                                    .kB12,
                                                                maxLines: 1,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Container(
                                                        height: 60,
                                                        width: 60,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.grey,
                                                          image: allList[index]
                                                                      .image ==
                                                                  null
                                                              ? null
                                                              : DecorationImage(
                                                                  image: CachedNetworkImageProvider(
                                                                      allList[index]
                                                                              .image ??
                                                                          ""),
                                                                ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              allList[index].members == null
                                                  ? SizedBox()
                                                  : Container(
                                                      height: allList[index]
                                                              .members!
                                                              .length *
                                                          75,
                                                      child: ListView.builder(
                                                        shrinkWrap: true,
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        itemCount:
                                                            allList[index]
                                                                .members!
                                                                .length,
                                                        itemBuilder:
                                                            (context, index2) {
                                                          // allList[index]
                                                          //     .members
                                                          //     ?.sort((a, b) => a
                                                          //         .position!
                                                          //         .compareTo(b
                                                          //             .position!));

                                                          return Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 5),
                                                            height: 70,
                                                            child: Stack(
                                                              children: [
                                                                Positioned(
                                                                  top: 0,
                                                                  left: 20,
                                                                  right: 0,
                                                                  child:
                                                                      Container(
                                                                    height: 70,
                                                                    width: double
                                                                        .infinity,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                      color: AppColors
                                                                          .appBackgroundColor,
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              50),
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          AutoSizeText(
                                                                            allList[index].members?[index2].name ??
                                                                                "",
                                                                            style:
                                                                                AppStyles.kBB14,
                                                                            maxLines:
                                                                                1,
                                                                          ),
                                                                          AutoSizeText(
                                                                            allList[index].members?[index2].position ??
                                                                                "",
                                                                            style:
                                                                                AppStyles.kB12,
                                                                            maxLines:
                                                                                1,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child:
                                                                      Container(
                                                                    height: 60,
                                                                    width: 60,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      color: Colors
                                                                          .grey,
                                                                      image: allList[index].members?[index2].image ==
                                                                              null
                                                                          ? null
                                                                          : DecorationImage(
                                                                              image: CachedNetworkImageProvider(
                                                                                allList[index].members?[index2].image ?? "",
                                                                              ),
                                                                            ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                            ],
                                          )
                                        : SizedBox(
                                            width: 0,
                                            height: 0,
                                          )),
                              ),
                              // : SizedBox(),
                              AnimatedPositioned(
                                duration: Duration(milliseconds: 200),
                                top: index == selectedItem
                                    ? initialButtonPositionOffset.dy
                                    : 30,
                                right: index == selectedItem
                                    ? initialButtonPositionOffset.dx
                                    : 10,
                                child: FloatingActionButton(
                                  backgroundColor: Color(0xff5591BF),
                                  elevation: 0,
                                  onPressed: () {
                                    setState(() {
                                      if (selectedItem == index) {
                                        //hide
                                        selectedItem = -1;
                                        initialButtonPosition = 30;
                                        initialButtonPositionOffset =
                                            Offset(10, 30);
                                        containerHeight = 0;
                                      } else {
                                        //show
                                        selectedItem = index;
                                        initialButtonPositionOffset =
                                            Offset(0, -4);
                                        allList[selectedItem].members == null
                                            ? null
                                            : containerHeight = 140 +
                                                (allList[selectedItem]
                                                        .members!
                                                        .length *
                                                    75);
                                      }
                                      // selectedItem = index;
                                      // // });
                                      // //Open??
                                      // if (index == selectedItem &&
                                      //     initialButtonPositionOffset.dy == 30) {
                                      //   // setState(() {
                                      //   // initialButtonPosition = -4;
                                      //   initialButtonPositionOffset =
                                      //       Offset(0, -4);
                                      //   allList[selectedItem].members == null
                                      //       ? null
                                      //       : containerHeight = 140 +
                                      //           (allList[selectedItem]
                                      //                   .members!
                                      //                   .length *
                                      //               75);
                                      //   // isDetail = true;
                                      //   // });
                                      // } else {
                                      //   ///close
                                      //   selectedItem = -1;
                                      //   initialButtonPosition = 30;
                                      //   initialButtonPositionOffset =
                                      //       Offset(10, 30);
                                      //   containerHeight = 0;
                                      //   // isDetail = false;
                                      //   // buildUI = false;
                                      //   // });
                                      // }
                                    });
                                  },
                                  mini: true,
                                  child: index == selectedItem
                                      ? initialButtonPositionOffset ==
                                              Offset(10, 30)
                                          ? Icon(Icons.add)
                                          : Icon(Icons.close)
                                      : Icon(Icons.add),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
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
