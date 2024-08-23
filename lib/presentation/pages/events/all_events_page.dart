import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rotary/core/resources/app_strings.dart';
import 'package:rotary/core/resources/app_styles.dart';
import 'package:rotary/data/models/event/event_model.dart';
import 'package:rotary/presentation/pages/events/event_detail_page.dart';

class AllEventsPage extends StatelessWidget {
  final List<EventModel> listOfEvents;
  const AllEventsPage({Key? key, required this.listOfEvents}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('All Events'),
        ),
        body: ListView.builder(
          physics: BouncingScrollPhysics(),
          padding: const EdgeInsets.all(8),
          itemCount: listOfEvents.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return EventDetailsPage(
                      title: listOfEvents[index].title!,
                      id: listOfEvents[index].id!,
                      upcomingEvents: listOfEvents);
                }));
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
                          "${listOfEvents[index].date}",
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          listOfEvents[index].location!,
                                          style: AppStyles.kPB12,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                listOfEvents[index].fromTime == "" &&
                                        listOfEvents[index].toTime == ""
                                    ? SizedBox()
                                    : Expanded(
                                        child: AutoSizeText(
                                          "${listOfEvents[index].fromTime} - ${listOfEvents[index].toTime}",
                                          // listOfEvents[index].fromTime! +
                                          //     " - " +
                                          //     listOfEvents[index].toTime!,
                                          style: AppStyles.kG14
                                              .copyWith(color: Colors.black54),
                                          maxLines: 1,
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
                                listOfEvents[index].title ?? "",
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
        ));
  }
}
