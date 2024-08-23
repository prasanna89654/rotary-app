import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rotary/core/resources/app_strings.dart';
import 'package:rotary/core/resources/app_styles.dart';
import 'package:rotary/core/utils/com_fun.dart';
import 'package:rotary/data/models/business_directory/ads/business_directory_ads_model.dart';
import 'package:rotary/data/models/business_directory/business_hours.dart';
import 'package:rotary/data/models/business_directory/user.dart';
import 'package:rotary/presentation/common_widgets/custom_textfield.dart';
import 'package:rotary/presentation/features/directory/directory_cubit.dart';
import 'package:rotary/presentation/pages/directory/business_detail_page.dart';
import 'package:rotary/presentation/pages/directory/directory_profile_page.dart';
import 'package:rotary/presentation/pages/directory/directory_search_page.dart';

import 'business_gallery_page.dart';

class DirectoryDetailPage extends StatefulWidget {
  final List<User> directoryUser;
  final String directoryTitle;
  late final List<User> willingToListBusinessUsers;
  final List<User> otherRotarianUsers = [];
  DirectoryDetailPage({
    Key? key,
    required this.directoryUser,
    required this.directoryTitle,
  }) : super(key: key) {
    willingToListBusinessUsers = directoryUser
        .where((element) => element.userDetails?.willingToListBusiness == "Yes")
        .toList();
    otherRotarianUsers.addAll(directoryUser);
    for (User user in willingToListBusinessUsers) {
      otherRotarianUsers.remove(user);
    }
  }

  @override
  State<DirectoryDetailPage> createState() => _DirectoryDetailPageState();
}

class _DirectoryDetailPageState extends State<DirectoryDetailPage> {
  String? selectedLocation;
  bool isFiltering = false;
  BusinessAdsModel? topAd;
  BusinessAdsModel? bottomAd;
  List<BusinessAdsModel> middleAds = [];
  List<String> locations = ["Kathmandu", "Pokhara", "Birgunj"];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final tempTopAd =
        BlocProvider.of<DirectoryCubit>(context).directoryDetailTopAd;
    final tempBottomAd =
        BlocProvider.of<DirectoryCubit>(context).directoryDetailBottomAd;
    final tempMiddleAd =
        BlocProvider.of<DirectoryCubit>(context).directoryDetailMiddleAds;
    if (tempTopAd?.classification?.name?.toLowerCase() ==
        widget.directoryTitle.toLowerCase()) {
      topAd = tempTopAd;
    }
    if (tempBottomAd?.classification?.name?.toLowerCase() ==
        widget.directoryTitle.toLowerCase()) {
      bottomAd = tempBottomAd;
    }
    middleAds = tempMiddleAd
        .where((element) =>
            element.classification?.name?.toLowerCase() ==
            widget.directoryTitle.toLowerCase())
        .toList();
  }

  bool checkOpenOrClosed(int index) {
    try {
      final now = DateTime.now();
      int dayOfWeek = now.weekday;
      String dayName = getDayOfWeekName(dayOfWeek);
      final List<BusinessHours> businessHours = [];
      var decodedHours =
          jsonDecode(widget.directoryUser[index].userDetails?.businessHours);
      for (var decodedhour in decodedHours) {
        businessHours.add(BusinessHours.fromMap(decodedhour));
      }
      final todayH =
          businessHours.firstWhere((element) => element.businessDay == dayName);
      final hours = todayH.businessTime?.split("-");
      if (hours != null) {
        final openTime = parseTimeStringToDateTime(hours[0]);
        final closeTime = parseTimeStringToDateTime(hours[1]);
        return isTimeInRange(now, openTime, closeTime);
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  filterLocation() {
    isFiltering = true;
    setState(() {});
    final filteredUsers = widget.directoryUser
        .where((element) =>
            element.userDetails?.buisnessDistrict == selectedLocation)
        .toList();
    widget.directoryUser.removeRange(0, widget.directoryUser.length);
    widget.willingToListBusinessUsers
        .removeRange(0, widget.willingToListBusinessUsers.length);
    widget.directoryUser.addAll(filteredUsers);
    final businessUsers = widget.directoryUser
        .where((element) => element.userDetails?.willingToListBusiness == "Yes")
        .toList();
    widget.willingToListBusinessUsers.addAll(businessUsers);
    widget.otherRotarianUsers.addAll(widget.directoryUser);
    for (User user in widget.willingToListBusinessUsers) {
      widget.otherRotarianUsers.remove(user);
    }
    isFiltering = false;
    setState(() {});
  }

  @override
  void dispose() {
    selectedLocation = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xFFEFEFEF),
          // appBar: AppBar(
          //   title: Text(widget.directoryTitle),
          // ),
          // endDrawer: Container(
          //   height: double.infinity,
          //   color: Colors.white,
          //   width: MediaQuery.of(context).size.width * 0.7,
          //   child: SafeArea(
          //     child: Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             "Filter by location",
          //             style: AppStyles.kBB18,
          //           ),
          //           SizedBox(
          //             height: 10,
          //           ),
          //           ...List.generate(4, (index) {
          //             return ListTileTheme(
          //               horizontalTitleGap: 2,
          //               child: CheckboxListTile(
          //                 dense: true,
          //                 visualDensity: VisualDensity.compact,
          //                 checkboxShape: RoundedRectangleBorder(
          //                     borderRadius: BorderRadius.circular(4)),
          //                 contentPadding: EdgeInsets.zero,
          //                 controlAffinity: ListTileControlAffinity.leading,
          //                 value: false,
          //                 onChanged: (value) {},
          //                 title: Text(index % 2 == 0 ? "Kathmandu" : "Pokhara",
          //                     style: TextStyle(
          //                       fontSize: 14,
          //                     )),
          //               ),
          //             );
          //           }),
          //           SizedBox(
          //             height: 10,
          //           ),
          //           SizedBox(
          //             height: 40,
          //             width: double.infinity,
          //             child: ElevatedButton(
          //               onPressed: () {
          //                 if (selectedLocation != null) {
          //                   // filterLocation();
          //                 } else {}
          //               },
          //               style: ButtonStyle(
          //                   fixedSize: MaterialStateProperty.all(
          //                       Size(double.infinity, 40))),
          //               child: Text("Apply Filter"),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 24),
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(2, 4),
                          blurRadius: 5,
                          color: Colors.grey.withOpacity(0.5)),
                    ],
                  ),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back)),
                      SizedBox(width: 10),
                      AutoSizeText(
                        widget.directoryTitle,
                        style: TextStyle(
                          color: Color(0xFF222222),
                          fontSize: 14,
                          fontFamily: 'Barlow',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              topAd != null
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                      child: Image.network(
                        topAd!.image ?? "",
                        width: double.infinity,
                        height: 72,
                        fit: BoxFit.cover,
                      ),
                    )
                  : SizedBox(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomTextField(
                  prefixIcon: Icon(CupertinoIcons.search),
                  readOnly: false,
                  borderColor: Colors.grey,
                  hintText: "Search directory name ...",
                  // controller: BlocProvider.of<DirectoryCubit>(context)
                  //     .searchDirectoryController,

                  // onChanged: (value) {
                  //   print(value);
                  //   BlocProvider.of<DirectoryCubit>(context)
                  //       .searchDirectory(value);
                  // },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: isFiltering
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : widget.directoryUser.isEmpty
                          ? Center(
                              child: Text("No users"),
                            )
                          : SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Dialog(
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      SizedBox(height: 30),
                                                      Text(
                                                        'Filters',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18,
                                                          fontFamily: 'Barlow',
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          height: 0,
                                                        ),
                                                      ),
                                                      SizedBox(height: 15),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 15),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Location',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    'Barlow',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                height: 0,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 20),
                                                            Divider(
                                                              color: Color(
                                                                  0xFFE4E4E4),
                                                            ),
                                                            ListView.separated(
                                                                shrinkWrap:
                                                                    true,
                                                                separatorBuilder:
                                                                    (context,
                                                                            index) =>
                                                                        Divider(
                                                                          color:
                                                                              Color(0xFFE4E4E4),
                                                                        ),
                                                                itemCount:
                                                                    locations
                                                                        .length,
                                                                itemBuilder:
                                                                    (context,
                                                                        index) {
                                                                  return Container(
                                                                    width: double
                                                                        .infinity,
                                                                    height: 40,
                                                                    // decoration:
                                                                    //     BoxDecoration(
                                                                    //   border: Border(
                                                                    //     top: BorderSide(
                                                                    //       color: Color(
                                                                    //           0xFFE4E4E4),
                                                                    //     ),
                                                                    //     bottom: BorderSide(
                                                                    //       width: 1,
                                                                    //       color: Color(
                                                                    //           0xFFE4E4E4),
                                                                    //     ),
                                                                    //   ),
                                                                    // ),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          'Kathmandu',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize:
                                                                                11,
                                                                            fontFamily:
                                                                                'Barlow',
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            height:
                                                                                0,
                                                                          ),
                                                                        ),
                                                                        Switch(
                                                                          value:
                                                                              true,
                                                                          activeColor:
                                                                              AppColors.rotaryBlue,
                                                                          onChanged:
                                                                              (val) {},
                                                                        )
                                                                      ],
                                                                    ),
                                                                  );
                                                                }),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Divider(),
                                                Container(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  height: 50,
                                                  width: double.infinity,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          'Cancel',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF0086D2),
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Barlow',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            height: 0,
                                                          ),
                                                        ),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          'Apply',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF0086D2),
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Barlow',
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            height: 0,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          20, 14, 20, 14),
                                      width: 48,
                                      height: 31,
                                      decoration: ShapeDecoration(
                                        color: Color(0xFF222222),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.tune,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Divider(),
                                  widget.willingToListBusinessUsers.isEmpty
                                      ? SizedBox()
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Text(
                                            "${widget.directoryTitle} Business",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontFamily: 'Barlow',
                                              fontWeight: FontWeight.w700,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                  ListView.separated(
                                    // controller: _scrollController,
                                    separatorBuilder: (context, index) =>
                                        Divider(),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    shrinkWrap: true,
                                    // itemCount: widget.directoryUser.length,
                                    physics: ClampingScrollPhysics(),
                                    itemCount: widget
                                        .willingToListBusinessUsers.length,
                                    itemBuilder: (context, index) {
                                      List<String> gallery = [];
                                      if (widget
                                              .willingToListBusinessUsers[index]
                                              .userDetails
                                              ?.gallery !=
                                          null) {
                                        var decodedGallery = jsonDecode(widget
                                            .willingToListBusinessUsers[index]
                                            .userDetails
                                            ?.gallery);
                                        for (var galleryImage
                                            in decodedGallery) {
                                          gallery.add(
                                              galleryImage['gallery_images']);
                                        }
                                      }
                                      return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BusinessDetailPage(
                                                        user: widget
                                                                .willingToListBusinessUsers[
                                                            index],
                                                      )),
                                            );
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 80,
                                                child: Stack(
                                                  children: [
                                                    ListView.separated(
                                                      itemCount:
                                                          gallery.length > 4
                                                              ? 4
                                                              : gallery.length,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      separatorBuilder:
                                                          (context, index) =>
                                                              SizedBox(
                                                                  width: 5),
                                                      itemBuilder:
                                                          (context, index2) {
                                                        return Container(
                                                          width: 108,
                                                          height: 77,
                                                          clipBehavior:
                                                              Clip.antiAlias,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                            color: Colors.grey,
                                                          ),
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl:
                                                                gallery[index2],
                                                            fit: BoxFit.cover,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                    gallery.length >= 4
                                                        ? Align(
                                                            alignment: Alignment
                                                                .bottomRight,
                                                            child: InkWell(
                                                              onTap: () {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              BusinessGalleryPage(
                                                                                businessGallery: gallery,
                                                                              )),
                                                                );
                                                              },
                                                              child: Container(
                                                                  width: 58,
                                                                  height: 20,
                                                                  decoration:
                                                                      ShapeDecoration(
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.8999999761581421),
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.only(
                                                                            bottomLeft:
                                                                                Radius.circular(4),
                                                                            topRight: Radius.circular(4),
                                                                            topLeft: Radius.circular(4))),
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                      'See All ${gallery.length}',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            10,
                                                                        fontFamily:
                                                                            'Barlow',
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        height:
                                                                            0,
                                                                      ),
                                                                    ),
                                                                  )),
                                                            ),
                                                          )
                                                        : SizedBox(),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    // "Teriyaki Madness",
                                                    widget
                                                        .willingToListBusinessUsers[
                                                            index]
                                                        .userDetails
                                                        ?.buisnessName,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                          "assets/images/circle_outlined.png"),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        // "Restaurant",
                                                        widget
                                                                .willingToListBusinessUsers[
                                                                    index]
                                                                .classification ??
                                                            "",
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                // "5910 SE 15th St, Ste 5, Midwest City",
                                                widget
                                                    .willingToListBusinessUsers[
                                                        index]
                                                    .userDetails
                                                    ?.buisnessAddress,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                // "+977 9845412777",
                                                widget
                                                    .willingToListBusinessUsers[
                                                        index]
                                                    .userDetails
                                                    ?.buisnessPhone,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Text.rich(
                                                // "Closed until 11:00 am",
                                                TextSpan(
                                                  text: checkOpenOrClosed(index)
                                                      ? "Open "
                                                      : "Closed ",
                                                  style: TextStyle(
                                                    color:
                                                        checkOpenOrClosed(index)
                                                            ? Colors.green
                                                            : AppColors.darkRed,
                                                    fontSize: 10,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text: "now",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                "Rtn. Chhongba Sherpa - RC BOUDHA",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ));
                                      // : SizedBox();
                                    },
                                  ),
                                  (widget.willingToListBusinessUsers
                                              .isNotEmpty &&
                                          widget.otherRotarianUsers.isNotEmpty)
                                      ? Divider()
                                      : SizedBox(),
                                  SizedBox(
                                    height: middleAds.isEmpty ? 0 : 10,
                                  ),
                                  middleAds.isNotEmpty
                                      ? Container(
                                          height: 122,
                                          margin: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: ListView.separated(
                                            itemCount: middleAds.length,
                                            physics: ClampingScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            separatorBuilder:
                                                (context, index) => SizedBox(
                                              width: 10,
                                            ),
                                            itemBuilder: (ctx, index) {
                                              return Container(
                                                width: 164,
                                                clipBehavior: Clip.hardEdge,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                child: Image.network(
                                                  middleAds[index].image ?? "",
                                                  width: 164,
                                                  fit: BoxFit.cover,
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                      : SizedBox(),
                                  SizedBox(
                                    height: middleAds.isEmpty ? 0 : 10,
                                  ),
                                  (widget.willingToListBusinessUsers
                                              .isNotEmpty &&
                                          widget.otherRotarianUsers.isNotEmpty)
                                      ? Divider()
                                      : SizedBox(),
                                  SizedBox(
                                    height: middleAds.isEmpty ? 0 : 10,
                                  ),
                                  widget.otherRotarianUsers.isEmpty
                                      ? SizedBox()
                                      : Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20, bottom: 10),
                                          child: Text(
                                            "Rotarians in ${widget.directoryTitle}",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontFamily: 'Barlow',
                                              fontWeight: FontWeight.w700,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                  Container(
                                    height: 320,
                                    width: double.infinity,
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      separatorBuilder: (context, index) =>
                                          SizedBox(width: 10),
                                      itemCount:
                                          widget.otherRotarianUsers.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DirectoryProfilePage(
                                                  user:
                                                      widget.otherRotarianUsers[
                                                          index],
                                                ),
                                              ),
                                            );
                                          },
                                          child: SizedBox(
                                            width: 190,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 200,
                                                  width: 190,
                                                  clipBehavior: Clip.hardEdge,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey
                                                        .withOpacity(0.3),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child: CachedNetworkImage(
                                                    height: double.infinity,
                                                    width: double.infinity,
                                                    imageUrl: widget
                                                            .otherRotarianUsers[
                                                                index]
                                                            .userDetails
                                                            ?.image ??
                                                        "",
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(
                                                      Icons.info,
                                                      color:
                                                          AppColors.rotaryBlue,
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      flex: 3,
                                                      child: SizedBox(
                                                        child: Text(
                                                          "${widget.otherRotarianUsers[index].firstname ?? ""} ${widget.otherRotarianUsers[index].middlename ?? ""} ${widget.otherRotarianUsers[index].lastname ?? ""}",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 2),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Image.asset(
                                                              "assets/images/circle_outlined.png"),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              // color: Colors.blue,
                                                              child: Text(
                                                                // "Restaurant",
                                                                widget
                                                                        .otherRotarianUsers[
                                                                            index]
                                                                        .classification ??
                                                                    "",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 10,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(height: 8),
                                                widget.otherRotarianUsers[index]
                                                            .phoneNo !=
                                                        null
                                                    ? Column(
                                                        children: [
                                                          Text(
                                                            widget
                                                                    .otherRotarianUsers[
                                                                        index]
                                                                    .phoneNo ??
                                                                "",
                                                            style: TextStyle(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          SizedBox(height: 8),
                                                        ],
                                                      )
                                                    : SizedBox(),
                                                widget.otherRotarianUsers[index]
                                                            .email !=
                                                        null
                                                    ? Column(
                                                        children: [
                                                          Text(
                                                            widget
                                                                .otherRotarianUsers[
                                                                    index]
                                                                .email!,
                                                            style: TextStyle(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          SizedBox(height: 9),
                                                        ],
                                                      )
                                                    : SizedBox(),
                                                // Text(
                                                //   "Rotary club of BOUDHA",
                                                //   style: TextStyle(
                                                //     fontSize: 10,
                                                //     fontWeight: FontWeight.w700,
                                                //   ),
                                                //   maxLines: 1,
                                                //   overflow: TextOverflow.ellipsis,
                                                // )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  bottomAd != null
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 20),
                                          child: Image.network(
                                            bottomAd!.image ?? "",
                                            width: double.infinity,
                                            height: 72,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : SizedBox(),
                                ],
                              ),
                            ),
                ),
              ),
            ],
          )

          // GridView.builder(
          //   shrinkWrap: true,
          //   // controller: _scrollController,
          //   physics: BouncingScrollPhysics(),
          //   itemCount: directoryUser.length,
          //   padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //     childAspectRatio: 1.05,
          //     crossAxisCount: 2,
          //     crossAxisSpacing: 16,
          //     mainAxisSpacing: 16,
          //   ),
          //   itemBuilder: (context, index) {
          //     return Container(
          //       padding: EdgeInsets.all(8),
          //       // color: Colors.white,
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(10),
          //         color: Colors.white,
          //       ),
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //         children: [
          //           Container(
          //             width: 50,
          //             height: 50,
          //             decoration: BoxDecoration(
          //                 image: DecorationImage(
          //                     image: CachedNetworkImageProvider(
          //                         directoryUser[index].userDetails?.buisnessImage ??
          //                             directoryUser[index].userDetails?.image ??
          //                             ""),
          //                     fit: BoxFit.cover),
          //                 color: AppColors.rotaryGold,
          //                 shape: BoxShape.circle),
          //           ),
          //           SizedBox(height: 10),
          //           AutoSizeText(
          //             "${directoryUser[index].firstname ?? ""} ${directoryUser[index].lastname ?? ""}",
          //             style: AppStyles.kBB12,
          //             maxLines: 1,
          //             minFontSize: 8,
          //             overflow: TextOverflow.ellipsis,
          //           ),
          //           // AutoSizeText(
          //           //   directoryUser[index].userDetails?.buisnessAddress ?? "",
          //           //   style: AppStyles.kB10,
          //           //   textAlign: TextAlign.center,
          //           //   minFontSize: 8,
          //           //   maxLines: 1,
          //           // ),
          //           // SizedBox(height: 5),
          //           // members[index].email == "" || members[index].email == null
          //           //     ? SizedBox()
          //           //     :
          //           InkWell(
          //             onTap: () async {
          //               final url = Uri(
          //                 scheme: "mailto",
          //                 path: directoryUser[index].email,
          //               );
          //               bool _canlaunch = await canLaunchUrl(url);
          //               if (_canlaunch) {
          //                 launchUrl(url);
          //               } else {
          //                 throw 'Could not launch $url';
          //               }
          //             },
          //             child: AutoSizeText(
          //               directoryUser[index].email ?? "",
          //               style: AppStyles.kB10,
          //               minFontSize: 5,
          //               maxLines: 1,
          //             ),
          //           ),

          //           // members[index].phone == "" || members[index].phone == null
          //           //     ? SizedBox()
          //           //     :
          //           InkWell(
          //             onTap: () async {
          //               final url = Uri(
          //                 scheme: "tel",
          //                 path: directoryUser[index].userDetails?.phone,
          //               );
          //               bool _canlaunch = await canLaunchUrl(url);
          //               if (_canlaunch) {
          //                 launchUrl(url);
          //               } else {
          //                 throw 'Could not launch $url';
          //               }
          //             },
          //             child: AutoSizeText(
          //               directoryUser[index].userDetails?.phone ?? "",
          //               style: AppStyles.kB10,
          //               minFontSize: 5,
          //               maxLines: 1,
          //             ),
          //           ),
          //           // members[index].classification == "" ||
          //           //         members[index].classification == null
          //           //     ? SizedBox()
          //           //     :
          //           // AutoSizeText(
          //           //   directoryUser[index].classification ?? "",
          //           //   style: AppStyles.kB10,
          //           //   minFontSize: 5,
          //           //   maxLines: 1,
          //           // ),
          //         ],
          //       ),
          //     );
          //   },
          // ),
          ),
    );
  }
}

/*Container(
                    margin: EdgeInsets.only(bottom: 8),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                    child: Card(
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            height: 170,
                            width: 120,
                            decoration: BoxDecoration(
                              color: AppColors.appBackgroundColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                              ),
                              // border: Border.all(color: Colors.grey),
                            ),
                            child: CachedNetworkImage(
                              imageUrl:
                                  widget.directoryUser[index].userDetails?.buisnessImage ??
                                      "",
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.info),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 40,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.grey.withOpacity(0.2)),
                                        child: CachedNetworkImage(
                                          imageUrl: widget.directoryUser[index]
                                                  .userDetails
                                                  ?.image ??
                                              "",
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.info),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Flexible(
                                        child: AutoSizeText(
                                          "${widget.directoryUser[index].firstname ?? ""} ${widget.directoryUser[index].lastname ?? ""}",
                                          style: AppStyles.kBB12,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  widget.directoryUser[index].addressLine2 != null
                                      ? Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              size: 15,
                                              color: AppColors.rotaryBlue,
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Expanded(
                                              child: AutoSizeText(
                                                "${widget.directoryUser[index].addressLine2 ?? ""}, ${widget.directoryUser[index].addressLine3 ?? ""}",
                                                style: AppStyles.kB12,
                                                maxLines: 1,
                                              ),
                                            ),
                                          ],
                                        )
                                      : SizedBox(),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    widget.directoryUser[index]
                                            .userDetails
                                            ?.buisnessName ??
                                        "Business Name",
                                    style: AppStyles.kBB16,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AutoSizeText(
                                              "${widget.directoryUser[index].userDetails?.buisnessAddress ?? "Thamel, Kathmandu"}",
                                              style: AppStyles.kB12,
                                              maxLines: 1,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            AutoSizeText(
                                              "${widget.directoryUser[index].userDetails?.buisnessAddress ?? "+9779845412777"}",
                                              style: AppStyles.kB12,
                                              maxLines: 1,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AutoSizeText(
                                              "${widget.directoryUser[index].userDetails?.buisnessPhone ?? "test@gmail.com"}",
                                              style: AppStyles.kB12,
                                              maxLines: 1,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            AutoSizeText(
                                              "${widget.directoryUser[index].userDetails?.buisnessPhone ?? "www..sherpatech.com"}",
                                              style: AppStyles.kB12,
                                              maxLines: 1,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),*/
