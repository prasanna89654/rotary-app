import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rotary/core/resources/app_constants.dart';
import 'package:rotary/core/resources/app_strings.dart';
import 'package:rotary/core/resources/app_styles.dart';
import 'package:rotary/data/models/event/event_response_model.dart';
import 'package:rotary/data/models/news/news_response_model.dart';
import 'package:rotary/presentation/features/home_page_bloc/homepage_bloc.dart';
import 'package:rotary/presentation/pages/events/all_events_page.dart';
import 'package:rotary/presentation/pages/events/event_detail_page.dart';
import 'package:rotary/presentation/pages/news/all_news_page.dart';
import 'package:rotary/presentation/pages/news/news_details_page.dart';

import '../../common_widgets/common_error_widget.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  ScrollController _scrollController = ScrollController();
  NewsResponseModel newsList = NewsResponseModel();
  EventResponseModel upcommingEventList = EventResponseModel();

  @override
  void initState() {
    super.initState();
    // BlocProvider.of<HomepageBloc>(context).add(GetHomePageDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        BlocProvider.of<HomepageBloc>(context).add(GetHomePageDataEvent());
        return Future.value(true);
      },
      child: BlocConsumer<HomepageBloc, HomepageState>(
        listener: (context, state) {
          // if (state is HomepageLoaded) {
          //   newsList.news = state.homeModel.news;
          //   upcommingEventList.upcommingEvents = state.homeModel.events;
          // }
        },
        builder: (context, state) {
          if (state is HomepageLoaded) {
            newsList.news = state.newsModel.news;
            upcommingEventList.upcommingEvents =
                state.upcommingEventModel.upcommingEvents;
          }
          if (state is HomepageError) {
            return CommonErrorWidget(message: state.message);
          }
          if (state is HomepageLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            controller: _scrollController,
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                children: [
                  upcommingEventList.upcommingEvents == null
                      ? SizedBox()
                      : _upcomingEventBody(context),
                  SizedBox(height: 10),
                  newsList.news == null ? SizedBox() : _recentNewsBody(context),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Column _recentNewsBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 20,
            // right: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    "No recent news",
                    style: AppStyles.kBB12,
                  ),
                ),
              )
            : Container(
                width: double.infinity,
                height: 260,
                child: ListView.builder(
                  controller: _scrollController,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      newsList.news!.length > 5 ? 5 : newsList.news!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewsDetailsPage(
                              id: newsList.news![index].id!,
                              newsList: newsList.news!,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        width: 190,
                        // height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: AppConstant.DefaultRadius,
                          // border: Border.all(
                          //   color: AppColors.BorderColor,
                          // ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              clipBehavior: Clip.antiAlias,
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(newsList
                                      .news![index].imageUrl
                                      .toString()),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  topLeft: Radius.circular(8),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                newsList.news![index].title!,
                                style: AppStyles.kB12,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: AppConstant.DefaultRadius,
                                      color: Color.fromARGB(255, 235, 78, 78),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: AutoSizeText(
                                        newsList.news![index].club!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        minFontSize: 8,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(newsList.news![index].getFormattedDate(),
                                      textAlign: TextAlign.right,
                                      style: AppStyles.kBB12)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ))
      ],
    );
  }

  Column _upcomingEventBody(BuildContext context) {
    return Column(
      children: [
        Row(
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
                      listOfEvents: upcommingEventList.upcommingEvents!,
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
        SizedBox(
          height: 20,
        ),
        upcommingEventList.upcommingEvents!.isEmpty
            ? Container(
                height: 150,
                child: Center(
                  child: Text(
                    "No upcoming events",
                    style: AppStyles.kBB12,
                  ),
                ),
              )
            : ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: upcommingEventList.upcommingEvents!.length > 5
                    ? 5
                    : upcommingEventList.upcommingEvents!.length,
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EventDetailsPage(
                            id: upcommingEventList.upcommingEvents![index].id!,
                            upcomingEvents: upcommingEventList.upcommingEvents!,
                            // id: upcommingEventList.upcommingEvents![index].id!,
                            // eventList: upcommingEventList.upcommingEvents!,
                          ),
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
                                )),
                            child: Center(
                              child: AutoSizeText(
                                "${upcommingEventList.upcommingEvents![index].date}",
                                maxLines: 1,
                                minFontSize: 8,
                                textAlign: TextAlign.center,
                                style: AppStyles.kWB18
                                    .copyWith(color: AppColors.rotaryGold),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              size: 15,
                                              color: AppColors.rotaryGold,
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Expanded(
                                              child: AutoSizeText(
                                                upcommingEventList
                                                    .upcommingEvents![index]
                                                    .location!,
                                                style: AppStyles.kPB12,
                                                maxLines: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      upcommingEventList.upcommingEvents?[index]
                                                      .fromTime ==
                                                  "" &&
                                              upcommingEventList
                                                      .upcommingEvents?[index]
                                                      .toTime ==
                                                  ""
                                          ? SizedBox()
                                          : Expanded(
                                              child: AutoSizeText(
                                                "${upcommingEventList.upcommingEvents?[index].fromTime ?? ""} - ${upcommingEventList.upcommingEvents?[index].toTime ?? ""}",
                                                // upcommingEventList
                                                //         .upcommingEvents![index]
                                                //         .fromTime! +
                                                //     " - " +
                                                //     upcommingEventList
                                                //         .upcommingEvents![index]
                                                //         .toTime!,
                                                style: AppStyles.kG14.copyWith(
                                                    color: Colors.black54),
                                                maxLines: 1,
                                                minFontSize: 8,
                                              ),
                                            ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Text(
                                      upcommingEventList
                                              .upcommingEvents![index].title ??
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
                  );
                }),
              )
      ],
    );
  }
}
