import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rotary/core/resources/app_constants.dart';
import 'package:rotary/core/resources/app_strings.dart';
import 'package:rotary/core/resources/app_styles.dart';
import 'package:rotary/core/utils/com_fun.dart';
import 'package:rotary/data/models/event/event_model.dart';
import 'package:rotary/data/models/event/event_response_model.dart';
import 'package:rotary/data/models/home/home_model.dart';
import 'package:rotary/data/models/news/news_response_model.dart';
import 'package:rotary/presentation/common_widgets/common_error_widget.dart';
import 'package:rotary/presentation/features/home_page_bloc/homepage_bloc.dart';
import 'package:rotary/presentation/pages/events/all_events_page.dart';
import 'package:rotary/presentation/pages/events/event_detail_page.dart';
import 'package:rotary/presentation/pages/news/all_news_page.dart';
import 'package:rotary/presentation/pages/news/news_details_page.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  // Animation<double> animation = 0.8;

  String time = parseHoursAMPM(DateTime.now());
  NewsResponseModel newsList = NewsResponseModel();
  HomeModel homeModel = HomeModel();
  EventResponseModel upcommingEventList = EventResponseModel();
  bool isExpanded = false;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      // triggerMode: RefreshIndicatorTriggerMode.anywhere,
      onRefresh: () async {
        BlocProvider.of<HomepageBloc>(context).add(GetHomePageDataEvent());

        return Future.value(true);
      },
      child: BlocConsumer<HomepageBloc, HomepageState>(
        listener: (context, state) {
          // if (state is HomepageLoaded) {
          //   setState(() {
          //     newsList = state.newsModel;
          //   homeModel = state.homeModel;
          //   upcommingEventList = state.upcommingEventModel;
          //   });
          //   print(newsList.news);
          //   print(upcommingEventList.upcommingEvents);
          // }
        },
        builder: (context, state) {
          if (state is HomepageError) {
            return CommonErrorWidget(message: state.message);
          }
          if (state is HomepageLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is HomepageLoaded) {
            // setState(() {
            newsList.news = state.newsModel.news;
            homeModel = state.homeModel;
            upcommingEventList.upcommingEvents =
                state.upcommingEventModel.upcommingEvents;
            upcommingEventList.upcommingEvents?.sort((a, b) {
              return convertDateFromString(a.date!)
                  .compareTo(convertDateFromString(b.date!));
            });
            // });
            // print(newsList.news);
            // print("upcom : ${upcommingEventList.upcommingEvents}");
            // print(homeModel.dg?.position);

            return CustomScrollView(
              physics: BouncingScrollPhysics(),
              controller: _scrollController,
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Container(
                    // height: 150,
                    child: homeModel.slider == null
                        ? SizedBox()
                        : CarouselSlider(
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
                            items: homeModel.slider?.map((e) {
                              int index = homeModel.slider!.indexOf(e);
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
                                      homeModel.slider![index].image ?? "",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: AutoSizeText(
                                        homeModel.slider![index].imageTitle!,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList()),
                  ),
                ),
                SliverToBoxAdapter(
                  child: homeModel.dg!.dgMessage == null
                      ? SizedBox()
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                // clipBehavior: Clip.antiAlias,
                                // height:  isExpanded ? double.infinity : 140,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      homeModel.dg?.dgMessage ?? "",
                                      style:
                                          AppStyles.kB14.copyWith(height: 1.5),
                                      maxLines: isExpanded ? null : 5,
                                      overflow: isExpanded
                                          ? null
                                          : TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      homeModel.dg?.name ?? "",
                                      style: AppStyles.kBB10,
                                    ),
                                    Text(
                                      homeModel.dg?.position ?? "",
                                      style: AppStyles.kBB10,
                                    )
                                  ],
                                ),
                              ),
                              // alignment: isExpanded ? Alignment.topRight : Alignment.bottomCenter,
                              Positioned(
                                right: isExpanded
                                    ? -10
                                    : (MediaQuery.of(context).size.width - 40) /
                                            2 -
                                        20,
                                bottom: isExpanded ? null : -10,
                                top: isExpanded ? -5 : null,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isExpanded = !isExpanded;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.rotaryBlue,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            blurRadius: 10,
                                            offset: Offset(0, 5),
                                          )
                                        ]),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        isExpanded
                                            ? Icons.close
                                            : Icons.arrow_downward,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 20, bottom: 20, right: 20),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Upcoming events",
                          style: AppStyles.HeadingStyle,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AllEventsPage(
                                  listOfEvents:
                                      upcommingEventList.upcommingEvents!,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: AppColors.rotaryBlue,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                upcommingEventList.upcommingEvents!.isEmpty ||
                        upcommingEventList.upcommingEvents == <EventModel>[]
                    ? SliverToBoxAdapter(
                        child: Container(
                          height: 150,
                          child: Center(
                            child: Text(
                              "No Upcoming Events",
                              style: AppStyles.kBB12,
                            ),
                          ),
                        ),
                      )
                    : SliverPadding(
                        padding: const EdgeInsets.only(
                            left: 20, bottom: 10, right: 20),
                        sliver: SliverAnimatedList(
                          initialItemCount: upcommingEventList
                                      .upcommingEvents ==
                                  null
                              ? 0
                              : upcommingEventList.upcommingEvents!.length > 5
                                  ? 5
                                  : upcommingEventList.upcommingEvents!.length,
                          itemBuilder: (context, index, animation) {
                            return SizeTransition(
                              sizeFactor: animation,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EventDetailsPage(
                                          title: upcommingEventList
                                              .upcommingEvents![index].title!,
                                          id: upcommingEventList
                                              .upcommingEvents![index].id!,
                                          upcomingEvents: upcommingEventList
                                              .upcommingEvents!),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(8),
                                        height: 80,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: AppColors.royalBlue,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomLeft: Radius.circular(8),
                                          ),
                                        ),
                                        child: Center(
                                          child: AutoSizeText(
                                            "${upcommingEventList.upcommingEvents![index].date}",
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            minFontSize: 8,
                                            style: AppStyles.kWB18.copyWith(
                                                color: AppColors.rotaryGold),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.location_on,
                                                          size: 15,
                                                          color: AppColors
                                                              .rotaryGold,
                                                        ),
                                                        SizedBox(
                                                          width: 4,
                                                        ),
                                                        Expanded(
                                                          child: AutoSizeText(
                                                            upcommingEventList
                                                                .upcommingEvents![
                                                                    index]
                                                                .location!,
                                                            style:
                                                                AppStyles.kPB12,
                                                            maxLines: 1,
                                                            minFontSize: 8,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  upcommingEventList
                                                                  .upcommingEvents?[
                                                                      index]
                                                                  .fromTime ==
                                                              "" &&
                                                          upcommingEventList
                                                                  .upcommingEvents?[
                                                                      index]
                                                                  .toTime ==
                                                              ""
                                                      ? SizedBox()
                                                      : Expanded(
                                                          child: AutoSizeText(
                                                            "${upcommingEventList.upcommingEvents?[index].fromTime ?? ""} - ${upcommingEventList.upcommingEvents?[index].toTime ?? ""}",
                                                            // upcommingEventList
                                                            //         .upcommingEvents![
                                                            //             index]
                                                            //         .fromTime! +
                                                            //     " - " +
                                                            //     upcommingEventList
                                                            //         .upcommingEvents![
                                                            //             index]
                                                            //         .toTime!,
                                                            style: AppStyles
                                                                .kG14
                                                                .copyWith(
                                                                    color: Colors
                                                                        .black54),
                                                            maxLines: 1,
                                                            minFontSize: 8,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5),
                                                child: Text(
                                                  upcommingEventList
                                                          .upcommingEvents![
                                                              index]
                                                          .title ??
                                                      "",
                                                  style: AppStyles.kB12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                SliverPadding(
                  padding: const EdgeInsets.only(left: 20, bottom: 20),
                  sliver: SliverToBoxAdapter(
                    child: newsList.news == [] || newsList.news == null
                        ? SizedBox()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 20,
                                  right: 20,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Recent News",
                                      style: AppStyles.HeadingStyle,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AllNewsPage(
                                              newsList: newsList.news!,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: AppColors.rotaryBlue,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              newsList.news!.isEmpty
                                  ? Container(
                                      height: 150,
                                      child: Center(
                                          child: Text(
                                        "No Recent News",
                                        style: AppStyles.kBB12,
                                      )),
                                    )
                                  : Container(
                                      width: double.infinity,
                                      height: 260,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: newsList.news == null
                                            ? 0
                                            : newsList.news!.length > 5
                                                ? 5
                                                : newsList.news!.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      NewsDetailsPage(
                                                    id: newsList
                                                        .news![index].id!,
                                                    newsList: newsList.news!,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  right: 8),
                                              width: 190,
                                              // height: 100,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    AppConstant.DefaultRadius,
                                                // border: Border.all(
                                                //   color: AppColors.BorderColor,
                                                // ),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Container(
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    height: 150,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      image: DecorationImage(
                                                        image:
                                                            CachedNetworkImageProvider(
                                                                newsList
                                                                    .news![
                                                                        index]
                                                                    .imageUrl
                                                                    .toString()),
                                                        fit: BoxFit.cover,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(8),
                                                        topLeft:
                                                            Radius.circular(8),
                                                      ),
                                                    ),
                                                  ),

                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      newsList
                                                          .news![index].title!,
                                                      style: AppStyles.kB12,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Wrap(
                                                      crossAxisAlignment:
                                                          WrapCrossAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                AppConstant
                                                                    .DefaultRadius,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    235,
                                                                    78,
                                                                    78),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        5),
                                                            child: AutoSizeText(
                                                              newsList
                                                                  .news![index]
                                                                  .club!,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              minFontSize: 8,
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        AutoSizeText(
                                                          newsList.news![index]
                                                              .getFormattedDate(),
                                                          textAlign:
                                                              TextAlign.right,
                                                          style:
                                                              AppStyles.kBB12,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  // Expanded(
                                                  //   child: Padding(
                                                  //     padding:
                                                  //         const EdgeInsets.all(
                                                  //             8.0),
                                                  //     child: Text(
                                                  //       newsList.news![index]
                                                  //           .description!,
                                                  //       // "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                                                  //       overflow:
                                                  //           TextOverflow.ellipsis,
                                                  //       maxLines: 2,
                                                  //       style: TextStyle(
                                                  //         fontSize: 14,
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ))
                            ],
                          ),
                  ),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}

class ActivitiesHeader extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: Container(
        padding: const EdgeInsets.only(left: 20, top: 10, bottom: 20),
        height: 50,
        child: Row(
          children: [
            Text(
              "Upcoming Events",
              style: AppStyles.HeadingStyle,
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class DGSectionPage extends StatelessWidget {
  const DGSectionPage({Key? key}) : super(key: key);

  Container _buildHeading(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      alignment: Alignment.center,
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.teal,
            Colors.blueGrey,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DG Section"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildHeading("Message from DG"),
            _buildHeading("BIO of DG"),
            _buildHeading("Guidelines for DG Club Visit"),
            _buildHeading("Checklists for DG Club Visit"),
          ],
        ),
      ),
    );
  }
}

class GeneralInfoPage extends StatelessWidget {
  const GeneralInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class DistrictTeamPage extends StatelessWidget {
  const DistrictTeamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class GMLPage extends StatelessWidget {
  const GMLPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class DistrictActivitiesPage extends StatelessWidget {
  const DistrictActivitiesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

/*SliverPadding(
                  padding: const EdgeInsets.all(AppConstant.DefaultPadding),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.BorderColor),
                        borderRadius: AppConstant.DefaultRadius,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: AppConstant.DefaultRadius,
                              color: Colors.grey,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Message from DG",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    homeModel.dg?.dgView ?? "",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DGMessageView(
                                                    dg: homeModel.dg ?? Dg(),
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              height: 30,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    AppConstant.DefaultRadius,
                                                color: AppColors.royalBlue,
                                              ),
                                              // width: double.infinity,
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Read more",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      // fontWeight: FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),*/
/*SliverPadding(
                  padding: const EdgeInsets.only(
                      left: AppConstant.DefaultPadding,
                      bottom: AppConstant.DefaultPadding),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                right: AppConstant.DefaultPadding),
                            width: 300,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: AppColors.BorderColor,
                                )),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  parseDisplayDate(DateTime.now()),
                                  style: AppStyles.kBB20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, bottom: 5),
                                      child: Text(
                                        time,
                                        // parseHoursAMPM(DateTime.now()),
                                        style: AppStyles.kB16,
                                      ),
                                    ),
                                    Text(
                                      "Today's Event Name",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                right: AppConstant.DefaultPadding),
                            width: 300,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: AppConstant.DefaultRadius,
                                border: Border.all(
                                  color: AppColors.BorderColor,
                                )),
                            child: TableComplexExample(),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                right: AppConstant.DefaultPadding),
                            width: 300,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: AppConstant.DefaultRadius,
                                border: Border.all(
                                  color: AppColors.BorderColor,
                                )),
                            child: ValueListenableBuilder<List<Event>>(
                              valueListenable: _selectedEvents,
                              builder: (context, value, _) {
                                return Column(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Upcoming Events",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: ListView.builder(
                                          itemCount: value.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              margin: const EdgeInsets.symmetric(
                                                horizontal: 12.0,
                                                vertical: 4.0,
                                              ),
                                              decoration: BoxDecoration(
                                                border: Border.all(),
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              child: ListTile(
                                                onTap: () =>
                                                    print('${value[index]}'),
                                                title: Text('${value[index]}'),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),*/

/*SliverPadding(
                  padding: const EdgeInsets.only(
                      left: AppConstant.DefaultPadding,
                      bottom: AppConstant.DefaultPadding),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            bottom: 8,
                          ),
                          child: Text(
                            "Message from RI President",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 250,
                          child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  width: 250,
                                  decoration: BoxDecoration(
                                    borderRadius: AppConstant.DefaultRadius,
                                    border: Border.all(
                                      color: AppColors.BorderColor,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          height: 100,
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        Text(
                                          "Message Title",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 4,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),*/
// SliverPersistentHeader(
//   // pinned: true,
//   delegate: ActivitiesHeader(),
// ),

/*SliverPersistentHeader(
                  // pinned: true,
                  delegate: ActivitiesHeader(),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 8, right: 8),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return SizedBox(
                          height: 250,
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  width: double.infinity,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: AppConstant.DefaultRadius,
                                    color: Colors.grey,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Title",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Description",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: 10,
                    ),
                  ),
                )*/

convertDateFromString(String strDate) {
  DateFormat dateFormat = DateFormat("MMM-dd-yyyy");
  DateTime formattedDate = dateFormat.parse(strDate);
  return formattedDate;
}
