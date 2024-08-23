import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rotary/core/resources/app_strings.dart';
import 'package:rotary/core/resources/app_styles.dart';
import 'package:rotary/data/models/event/event_details_model/event_details_model.dart';
import 'package:rotary/data/models/event/event_model.dart';
import 'package:rotary/presentation/features/event/event_bloc.dart';
import 'package:rotary/presentation/pages/events/all_events_page.dart';

class EventDetailsPage extends StatefulWidget {
  final String id;
  final List<EventModel>? upcomingEvents;
  final String? title;
  const EventDetailsPage({Key? key, this.upcomingEvents, required this.id,  this.title})
      : super(key: key);

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<EventBloc>(context).add(GetEventDetails(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    // log(widget.upcomingEvents.length.toString());
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      appBar: AppBar(
        title: Text(widget.title?? "Event Details"),
      ),
      body: BlocBuilder<EventBloc, EventState>(
        builder: (context, state) {
          if (state is EventLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is EventLoaded) {
            return _buildEventDetails(context, state.eventDetailsModel);
          }
          if (state is EventError) {
            return Center(
              child: Text(state.error),
            );
          }
          return Container();
          // return _buildEventDetails(context, );
        },
      ),
    );
  }

  Widget _buildEventDetails(
      BuildContext context, EventDetailsModel eventDetailsModel) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              eventDetailsModel.info?.title ?? "",
              // "DG Installation Program, July 01, Kathmandu",
              style: AppStyles.kBB14,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8),
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.rotaryGold),
              child: Row(children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 40,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          child: AutoSizeText(
                        eventDetailsModel.info?.location ?? "",
                        // "Hotel Soaltee, Kathmandu, Nepal",
                        style: AppStyles.kB12,
                      )),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month,
                      size: 40,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            eventDetailsModel.info?.date ?? "",
                            // "July 01, 2020",
                            style: AppStyles.kB12,
                          ),
                          eventDetailsModel.info?.fromTime == null &&
                                  eventDetailsModel.info?.toTime == null
                              ? SizedBox()
                              : Text(
                                  "${eventDetailsModel.info?.fromTime ?? ""} - ${eventDetailsModel.info?.toTime ?? ""}",
                                  style: AppStyles.kB12,
                                ),
                        ])
                  ],
                )
              ]),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              eventDetailsModel.info?.description ?? "",
              // "District Governor Installation Program is scheduled to be held on July 01 , 2022 in Kathmandu , Nepal at Soaltee Hotel",
              style: AppStyles.kB12,
            ),
            SizedBox(
              height: 30,
            ),
            widget.upcomingEvents == null
                ? SizedBox()
                : Row(
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
                                  listOfEvents: widget.upcomingEvents!),
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
            widget.upcomingEvents == null
                ? Container()
                : widget.upcomingEvents!.isEmpty ||
                        widget.upcomingEvents == <EventModel>[]
                    ? Container(
                        height: 150,
                        child: Center(
                          child: Text(
                            "No Upcoming Events",
                            style: AppStyles.kBB12,
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: widget.upcomingEvents!.length > 4
                              ? 4
                              : widget.upcomingEvents!.length,
                          itemBuilder: (context, index) {
                            int indexOfItemTobeRemoved = widget.upcomingEvents!
                                .indexWhere(
                                    (element) => element.id == widget.id);
                            return InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EventDetailsPage(
                                      id: widget.upcomingEvents![index].id ??
                                          "",
                                      upcomingEvents: widget.upcomingEvents,
                                    ),
                                  ),
                                );
                              },
                              child: index == indexOfItemTobeRemoved
                                  ? Container()
                                  : Container(
                                      margin: EdgeInsets.only(bottom: 8),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8)),
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
                                                  bottomLeft:
                                                      Radius.circular(8),
                                                )),
                                            child: Center(
                                              child: AutoSizeText(
                                                "${widget.upcomingEvents![index].date}",
                                                minFontSize: 8,
                                                maxLines: 1,
                                                textAlign: TextAlign.center,
                                                style: AppStyles.kWB18.copyWith(
                                                    color:
                                                        AppColors.rotaryGold),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                                              child:
                                                                  AutoSizeText(
                                                                widget
                                                                        .upcomingEvents![
                                                                            index]
                                                                        .location ??
                                                                    "",
                                                                style: AppStyles
                                                                    .kPB12,
                                                                maxLines: 1,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      widget
                                                                      .upcomingEvents![
                                                                          index]
                                                                      .fromTime ==
                                                                  "" &&
                                                              widget
                                                                      .upcomingEvents![
                                                                          index]
                                                                      .toTime ==
                                                                  ""
                                                          ? SizedBox()
                                                          : Expanded(
                                                              child:
                                                                  AutoSizeText(
                                                                "${widget.upcomingEvents![index].fromTime ?? ""} - ${widget.upcomingEvents![index].toTime ?? ""}",
                                                                // widget
                                                                //         .upcomingEvents[
                                                                //             index]
                                                                //         .fromTime ?? "" +
                                                                //     " - " +
                                                                //     widget
                                                                //         .upcomingEvents[
                                                                //             index]
                                                                //         .toTime! ,
                                                                style: AppStyles
                                                                    .kG14
                                                                    .copyWith(
                                                                        color: Colors
                                                                            .black54),
                                                                maxLines: 1,
                                                              ),
                                                            ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5),
                                                    child: Text(
                                                      widget
                                                              .upcomingEvents![
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
                            );
                          },
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
