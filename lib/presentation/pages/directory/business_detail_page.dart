import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:rotary/core/utils/com_fun.dart';
import 'package:rotary/data/models/business_directory/ads/business_directory_ads_model.dart';
import 'package:rotary/data/models/business_directory/business_features.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:rotary/data/models/business_directory/user.dart';
import 'package:rotary/data/models/business_directory/business_hours.dart';
import 'package:rotary/presentation/common_widgets/custom_textfield.dart';
import 'package:rotary/presentation/features/directory/directory_cubit.dart';
import 'package:rotary/presentation/pages/directory/business_gallery_page.dart';
import 'package:rotary/presentation/pages/directory/widgets/business_directory_stickey_header_widget.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/resources/app_strings.dart';
import '../../common_widgets/common_dialog.dart';

class BusinessDetailPage extends StatefulWidget {
  final User user;
  final List<BusinessHours> businessHours = [];

  final List<String> businessGallery = [];

  final List<BusinessFeatures> businessFeatures = [];
  BusinessDetailPage({Key? key, required this.user}) : super(key: key) {
    if (user.userDetails?.businessHours != null) {
      var decodedHours = jsonDecode(user.userDetails?.businessHours);
      for (var decodedhour in decodedHours) {
        businessHours.add(BusinessHours.fromMap(decodedhour));
      }
    }
    if (user.userDetails?.gallery != null) {
      var decodedGallery = jsonDecode(user.userDetails?.gallery);
      for (var galleryImage in decodedGallery) {
        businessGallery.add(galleryImage['gallery_images']);
      }
    }
    if (user.userDetails?.features != null) {
      var decodedFeatures = jsonDecode(user.userDetails?.features);
      for (var feature in decodedFeatures) {
        businessFeatures.add(BusinessFeatures.fromJson(feature));
      }
    }
  }

  @override
  State<BusinessDetailPage> createState() => _BusinessDetailPageState();
}

class _BusinessDetailPageState extends State<BusinessDetailPage> {
  final GlobalKey descriptionKey = GlobalKey();

  final GlobalKey infoKey = GlobalKey();

  final GlobalKey fetaureKey = GlobalKey();

  final GlobalKey galleryKey = GlobalKey();

  final ScrollController _scrollController = ScrollController();
  int selectedTab = 0;

  final listofWeeks = ['Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat'];
  late final List offsets;

  Offset getWidgetOffset(GlobalKey key) {
    RenderBox? renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    Offset? offset = renderBox?.localToGlobal(Offset.zero);
    return offset ?? Offset(0, 0);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      offsets = [];
      offsets.add(getWidgetOffset(descriptionKey).dy - 90.0);
      offsets.add(getWidgetOffset(infoKey).dy - 90.0);
      offsets.add(getWidgetOffset(fetaureKey).dy - 90.0);
      offsets.add(getWidgetOffset(galleryKey).dy - 90.0);
      // After the first frame, get the initial offset
      print("descriptionKey: ${getWidgetOffset(descriptionKey).dy}");
      print("infokey: ${getWidgetOffset(infoKey).dy}");
      print("fetaureKey: ${getWidgetOffset(fetaureKey).dy}");
      print("galleryKey: ${getWidgetOffset(galleryKey).dy}");
      print("offset: $offsets");
    });
    _scrollController.addListener(() {
      print("_scrollController.offset: ${_scrollController.offset}");
      if (_scrollController.offset < offsets[1]) {
        setState(() {
          selectedTab = 0;
        });
      } else if (_scrollController.offset > offsets[1] &&
          _scrollController.offset < offsets[2]) {
        print("info");
        setState(() {
          selectedTab = 1;
        });
      } else if (_scrollController.offset > offsets[2] &&
          _scrollController.offset < offsets[3]) {
        print("feature");
        setState(() {
          selectedTab = 2;
        });
      } else if (_scrollController.offset > offsets[3]) {
        print("gallery");
        setState(() {
          selectedTab = 3;
        });
      }
      // print(_scrollController.offset > getWidgetOffset(descriptionKey).dy);
      // print("getWidgetOffset(): ${getWidgetOffset(descriptionKey)}");
      // print("getWidgetOffset(): ${getWidgetOffset(infoKey)}");
      // print("getWidgetOffset(): ${getWidgetOffset(fetaureKey)}");
      // print("getWidgetOffset(): ${getWidgetOffset(galleryKey)}");
    });
  }

  String findTodayHours() {
    try {
      final now = DateTime.now();
      int dayOfWeek = now.weekday;
      String dayName = getDayOfWeekName(dayOfWeek);
      final todayH = widget.businessHours
          .firstWhere((element) => element.businessDay == dayName);
      return todayH.businessTime ?? "";
    } catch (e) {
      return "";
    }
  }

  bool checkOpenOrClosed() {
    try {
      final now = DateTime.now();
      int dayOfWeek = now.weekday;
      String dayName = getDayOfWeekName(dayOfWeek);
      final todayH = widget.businessHours
          .firstWhere((element) => element.businessDay == dayName);
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

  BusinessAdsModel? topAd;

  @override
  Widget build(BuildContext context) {
    print("_scrollController.offset: ${_scrollController.initialScrollOffset}");
    print("descriptionKey: ${getWidgetOffset(descriptionKey).dy}");
    print("infokey: ${getWidgetOffset(infoKey).dy}");
    print("fetaureKey: ${getWidgetOffset(fetaureKey).dy}");
    print("galleryKey: ${getWidgetOffset(galleryKey).dy}");
    final ad = BlocProvider.of<DirectoryCubit>(context).bussinessDetailTopAd;
    if (ad?.classification?.name?.toLowerCase() ==
        widget.user.classification?.toLowerCase()) {
      topAd = BlocProvider.of<DirectoryCubit>(context).bussinessDetailTopAd;
    } else {
      topAd = null;
    }
    return Scaffold(
        body: SafeArea(
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: 320,
              width: double.infinity,
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        height: 260,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          image: widget.businessHours.isNotEmpty
                              ? DecorationImage(
                                  colorFilter: new ColorFilter.mode(
                                    Colors.black.withOpacity(0.3),
                                    BlendMode.darken,
                                  ),
                                  image: CachedNetworkImageProvider(
                                    widget.businessGallery[0],
                                  ),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () => Navigator.pop(context),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.arrow_back_ios_new_sharp,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "Back",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 0, 30, 50),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Text(
                                    //   // "Teriyaki Madness",
                                    //   user.userDetails?.buisnessName,
                                    //   style: TextStyle(
                                    //     fontSize: 20,
                                    //     color: Colors.white,
                                    //     fontWeight: FontWeight.w700,
                                    //   ),
                                    // ),
                                    // SizedBox(height: 5),
                                    // Text(
                                    //   // "Teriyaki Madness",
                                    //   user.userDetails?.buisnessSlogan,
                                    //   style: TextStyle(
                                    //     fontSize: 16,
                                    //     color: Colors.white,
                                    //     fontWeight: FontWeight.w500,
                                    //   ),
                                    // ),
                                    // SizedBox(height: 10),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                BusinessGalleryPage(
                                              businessGallery:
                                                  widget.businessGallery,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: double.infinity,
                                        height: 23,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          color: Colors.grey.withOpacity(0.5),
                                          // backgroundBlendMode: BlendMode.colorBurn
                                        ),
                                        child: Text(
                                          "See all ${widget.businessGallery.length} photos",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        // child: businessHours.isNotEmpty
                        //     ? CachedNetworkImage(
                        //         imageUrl: businessGallery[0],
                        //         fit: BoxFit.cover,
                        //       )
                        //     : null,
                      ),
                      Container(
                        height: 60,
                        width: double.infinity,
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 5,
                            offset: Offset(-2, 4),
                          )
                        ]),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 120, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                // "Rotarian Name",
                                widget.user.userDetails?.buisnessName,
                                // "${user.firstname ?? ""} ${user.middlename ?? ""} ${user.lastname ?? ""}",
                                // user.userDetails?.buisnessName,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                // "Member since Nov 24, 2017",
                                widget.user.userDetails?.buisnessSlogan,
                                // "Member since ${convertToMMMDY(user.admitDate) ?? ""}",
                                // user.userDetails?.buisnessSlogan,
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10, left: 30),
                      height: 80,
                      width: 80,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(2, 4),
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 5),
                          ]
                          // image: DecorationImage(
                          //   colorFilter: new ColorFilter.mode(
                          //     Colors.black.withOpacity(0.2),
                          //     BlendMode.darken,
                          //   ),
                          //   image: CachedNetworkImageProvider(
                          //     user.userDetails?.buisnessImage,
                          //   ),
                          //   fit: BoxFit.cover,
                          // ),
                          ),
                      child: CachedNetworkImage(
                        imageUrl: widget.user.userDetails?.buisnessImage,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 80,
              padding: const EdgeInsets.fromLTRB(30, 10, 10, 10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xffD9D9D9),
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    // "Restaurant",
                    widget.user.classification ?? "",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        checkOpenOrClosed() ? "Open now" : "Closed now",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.red.shade900,
                          fontWeight: FontWeight.bold,
                          // fontWeight: FontWeith.wSymbol(figma.mixed),
                        ),
                      ),
                      findTodayHours() != ""
                          ? Text(
                              " ・ ",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          : SizedBox(),
                      Text(
                        findTodayHours(),
                        style: TextStyle(
                          fontSize: 14,
                          // fontWeight: FontWeith.wSymbol(figma.mixed),
                        ),
                      ),
                      findTodayHours() != ""
                          ? Text(
                              " ・ ",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : SizedBox(),
                      findTodayHours() == "" ? SizedBox(width: 10) : SizedBox(),
                      InkWell(
                        onTap: () {
                          _bussinessHoursBottomSheet(context);
                        },
                        child: Text(
                          "See hours",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          
          SliverToBoxAdapter(
            child: Container(
              height: 80,
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xffD9D9D9),
                  ),
                ),
              ),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildItemRowWidget(
                    Icons.map_outlined,
                    "Get Direction",
                    onTap: () async {
                      final url = Uri.parse(
                          widget.user.userDetails?.googleAddress ?? "");
                      bool _canlaunch = await canLaunchUrl(url);
                      if (_canlaunch) {
                        launchUrl(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  _buildItemRowWidget(
                    Icons.link,
                    "Website",
                    onTap: () async {
                      final url =
                          Uri.parse(widget.user.userDetails?.buisnessUrl);
                      bool _canlaunch = await canLaunchUrl(url);
                      if (_canlaunch) {
                        launchUrl(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  _buildItemRowWidget(Icons.share, "Share", onTap: () async {
                    final userId = widget.user.userDetails?.userId;
                    final url =
                        "https://rotarydistrict3292.org.np/detail/${userId.toString()}";
                    await Share.share(
                      url,
                      // subject: subject,
                      // sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
                    );
                  }),
                ],
              ),
            ),
          ),
          SliverPersistentHeader(
              pinned: true, delegate: BusinessStickeyHeader(selectedTab)),
          SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
          SliverToBoxAdapter(
            child: Container(
              key: descriptionKey,
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  HtmlWidget(widget.user.userDetails?.buisnessDescription)
                  // Html(
                  //   // "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                  //   data: user.userDetails?.buisnessDescription,
                  //   // style: TextStyle(
                  //   //   fontSize: 11,
                  //   //   fontWeight: FontWeight.w400,
                  //   // ),
                  //   // textAlign: TextAlign.justify,
                  // )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
          SliverToBoxAdapter(
              child: topAd != null
                  ? Padding(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, bottom: 30),
                      child: CachedNetworkImage(
                        imageUrl: topAd!.image ?? "",
                        height: 72,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )
                  : SizedBox()),
          SliverToBoxAdapter(
            child: Container(
              key: infoKey,
              color: Colors.white,
              // padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      "Business Info",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  _buildInfo("Hours",
                      isColored: true,
                      value:
                          "${checkOpenOrClosed() ? "Open now" : "Closed now"} ・${findTodayHours().toString()}",
                      icon: Icons.arrow_forward, onIconTap: () {
                    _bussinessHoursBottomSheet(context);
                  }),
                  _buildInfo(
                    "Website",
                    value: widget.user.userDetails?.buisnessUrl,
                    icon: Icons.ios_share,
                    onIconTap: () async {
                      final url =
                          Uri.parse(widget.user.userDetails?.buisnessUrl ?? "");
                      bool _canlaunch = await canLaunchUrl(url);
                      if (_canlaunch) {
                        launchUrl(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                  ),
                  widget.user.userDetails?.buisnessPhone != null
                      ? _buildInfo(
                          "Phone",
                          value: widget.user.userDetails?.buisnessPhone,
                          icon: Icons.ios_share,
                          onIconTap: () async {
                            final url = Uri(
                                scheme: 'tel',
                                path: widget.user.userDetails?.buisnessPhone ??
                                    "");
                            bool _canlaunch = await canLaunchUrl(url);
                            if (_canlaunch) {
                              launchUrl(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                        )
                      : SizedBox(),
                  widget.user.userDetails?.buisnessEmail != null
                      ? _buildInfo(
                          "Email",
                          value: widget.user.userDetails?.buisnessEmail,
                          icon: Icons.ios_share,
                          onIconTap: () async {
                            final url = Uri(
                                scheme: 'mailto',
                                path: widget.user.userDetails?.buisnessEmail ??
                                    "");
                            bool _canlaunch = await canLaunchUrl(url);
                            if (_canlaunch) {
                              launchUrl(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                        )
                      : SizedBox(),
                  widget.user.userDetails?.buisnessAddress != null
                      ? _buildInfo(
                          "Address",
                          value: widget.user.userDetails?.buisnessAddress,
                          icon: Icons.ios_share,
                          onIconTap: () async {
                            final url = Uri.parse(
                                widget.user.userDetails?.googleAddress ?? "");
                            bool _canlaunch = await canLaunchUrl(url);
                            if (_canlaunch) {
                              launchUrl(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                        )
                      : SizedBox(),
                  // _buildInfo(
                  //   "Get Direction",
                  //   // value:
                  //   //     user.userDetails?.buisnessAddress,
                  //   icon: Icons.directions,
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              key: fetaureKey,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Features",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                          onTap: () {
                            _businessFeaturesBottomSheet(context);
                          },
                          child: Icon(Icons.arrow_forward),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 10),
                      itemCount: widget.businessFeatures.length > 3
                          ? 3
                          : widget.businessFeatures.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              alignment: Alignment.center,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: Colors.red.shade900.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child:
                                  widget.businessFeatures[index].featureImage ==
                                              null ||
                                          widget.businessFeatures[index]
                                                  .featureImage ==
                                              ""
                                      ? Text(
                                          widget.businessFeatures[index]
                                              .featureTitle!.characters.first,
                                          style: TextStyle(
                                              color: Colors.red.shade900,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        )
                                      : CachedNetworkImage(
                                          imageUrl: widget
                                                  .businessFeatures[index]
                                                  .featureImage ??
                                              "",
                                        ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              widget.businessFeatures[index].featureTitle ?? "",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        );
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
          SliverToBoxAdapter(
            child: Container(
              key: galleryKey,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Gallery",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BusinessGalleryPage(
                                  businessGallery: widget.businessGallery,
                                ),
                              ),
                            );
                          },
                          child: Icon(Icons.arrow_forward),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.businessGallery.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1.3),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            showCommonDialog(
                                context, widget.businessGallery[index]);
                          },
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                  widget.businessGallery[index],
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xffD9D9D9),
                  ),
                  top: BorderSide(
                    color: Color(0xffD9D9D9),
                  ),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // "Rotarian Name",
                      // user.userDetails?.buisnessName,
                      "${widget.user.firstname ?? ""} ${widget.user.middlename ?? ""} ${widget.user.lastname ?? ""}",
                      // user.userDetails?.buisnessName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      // "Member since Nov 24, 2017",
                      // user.userDetails?.buisnessSlogan,
                      "Member since ${convertToMMMDY(widget.user.admitDate) ?? ""}",
                      // user.userDetails?.buisnessSlogan,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
          SliverToBoxAdapter(
              child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Contact Business",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    hintText: "Enter your name",
                    labelText: "Name",
                    borderColor: Colors.black,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    hintText: "Enter your email",
                    labelText: "Email",
                    borderColor: Colors.black,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    hintText: "Enter your message",
                    labelText: "Message",
                    borderColor: Colors.black,
                    maxLines: 5,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(
                                Size(double.infinity, 50)),
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xffa60000))),
                        child: Text("Send Message")),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          )),
          SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      "People Also Viewed",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.grey.withOpacity(0.7),
                    ),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 5),
                        child: Row(
                          children: [
                            Container(
                              height: 70,
                              width: 120,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          "assets/images/menu_background.jpg"))),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Koutry Style Kitchen Restaurant",
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text("Restaurant",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            )),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text("Thamel, kathmandu",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            )),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text("+977 9876543210",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            )),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.rotaryBlue,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Icon(
                                          Icons.arrow_forward_outlined,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    )
        /*Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                  options: CarouselOptions(
                    viewportFraction: 1,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    pauseAutoPlayInFiniteScroll: true,
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                    // onPageChanged: (index, reason) {
                    //   setState(() {
                    //     _current = index;
                    //   });
                    // },
                  ),
                  items: user.userDetails?.gallery == null
                      ? tempImages.map((e) {
                          int index = tempImages.indexOf(e);
                          return Container(
                            width: double.infinity,
                            color: Colors.white,
                            child: e,
                          );
                        }).toList()
                      : user.userDetails?.gallery.map((e) {
                          int index = user.userDetails?.gallery.indexOf(e);
                          return Container(
                            // height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                colorFilter: new ColorFilter.mode(
                                  Colors.black.withOpacity(0.2),
                                  BlendMode.darken,
                                ),
                                image: CachedNetworkImageProvider(
                                  user.userDetails?.gallery[index] ?? "",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            // child: Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Align(
                            //     alignment: Alignment.bottomLeft,
                            //     child: Padding(
                            //       padding: const EdgeInsets.all(8.0),
                            //       child: AutoSizeText(
                            //         homeModel.slider![index].imageTitle!,
                            //         style: TextStyle(
                            //           fontSize: 14,
                            //           fontWeight: FontWeight.bold,
                            //           color: Colors.white,
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          );
                        }).toList()),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: CachedNetworkImage(
                      imageUrl: user.userDetails?.buisnessImage ?? "",
                      errorWidget: (context, url, error) => Icon(Icons.info),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          user.userDetails?.buisnessName ??
                              "Sleep In a Room in Apartment",
                          style: AppStyles.kBB16,
                        ),
                        AutoSizeText(
                          user.userDetails?.buisnessSlogan ??
                              "Luxury hotel in the heart of Blommsbury",
                          style: AppStyles.kB14,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.\n\nIt has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.\n\nLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'''),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Hours",
                  style: AppStyles.kBB16,
                ),
              ),
              Card(
                child: Column(
                  // shrinkWrap: true,
                  children: List.generate(listofWeeks.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AutoSizeText(
                            listofWeeks[index],
                            style: AppStyles.kB14
                                .copyWith(color: Colors.black.withOpacity(0.8)),
                          ),
                          AutoSizeText(
                            "11:00 AM - 3:00 PM",
                            style: AppStyles.kBB14,
                          )
                        ],
                      ),
                    );
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Gallery",
                  style: AppStyles.kBB16,
                ),
              ),
              GridView.builder(
                  shrinkWrap: true,
                  itemCount: 6,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.withOpacity(0.2))),
                    );
                  })
            ],
          ),
        ),
      ),*/
        );
  }

  Future<dynamic> _bussinessHoursBottomSheet(BuildContext context) {
    final dayName = getDayOfWeekName(DateTime.now().weekday);
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Wrap(
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey.withOpacity(0.5),
                        ),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Hours",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(Icons.close),
                            ))
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(30),
                    separatorBuilder: (context, i) => SizedBox(
                      height: 15,
                    ),
                    itemCount: widget.businessHours.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${widget.businessHours[index].businessDay ?? ""}${widget.businessHours[index].businessDay == dayName ? "(today)" : ""}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight:
                                    widget.businessHours[index].businessDay ==
                                            dayName
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                              ),
                            ),
                            Text(
                              widget.businessHours[index].businessTime ?? "",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight:
                                    widget.businessHours[index].businessDay ==
                                            dayName
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInfo(String title,
      {String? value,
      Widget? child,
      IconData? icon,
      Function()? onIconTap,
      bool? isColored = false}) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xffD9D9D9),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 5),
                  value != null
                      ? isColored == true
                          ? Row(
                              children: [
                                Text(
                                  value.substring(0, value.indexOf("・")),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: value.startsWith("Open")
                                        ? Colors.green
                                        : AppColors.darkRed,
                                  ),
                                ),
                                Text(
                                  value.substring(value.indexOf("・")),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            )
                          : Text(
                              value,
                              style: TextStyle(
                                fontSize: 12,
                                // fontWeight: FontWeith.wSymbol(figma.mixed),
                              ),
                            )
                      : SizedBox(),
                  child != null ? child : SizedBox(),
                ],
              ),
            ),
            InkWell(onTap: onIconTap, child: Icon(icon))
          ],
        ),
      ),
    );
  }

  _buildItemRowWidget(IconData icon, String text, {void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 17,
            backgroundColor: Color(0xffd9d9d9),
            child: Icon(
              icon,
              size: 20,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }

  _businessFeaturesBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Wrap(
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey.withOpacity(0.5),
                        ),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Features",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(Icons.close),
                            ))
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(30),
                    separatorBuilder: (context, i) => SizedBox(
                      height: 15,
                    ),
                    itemCount: widget.businessFeatures.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            alignment: Alignment.center,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              color: Colors.red.shade900.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child:
                                widget.businessFeatures[index].featureImage ==
                                            null ||
                                        widget.businessFeatures[index]
                                                .featureImage ==
                                            ""
                                    ? Text(
                                        widget.businessFeatures[index]
                                            .featureTitle!.characters.first,
                                        style: TextStyle(
                                            color: Colors.red.shade900,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      )
                                    : CachedNetworkImage(
                                        imageUrl: widget.businessFeatures[index]
                                                .featureImage ??
                                            "",
                                      ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            widget.businessFeatures[index].featureTitle ?? "",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
