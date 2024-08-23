import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:rotary/core/resources/app_strings.dart';
import 'package:rotary/core/resources/app_styles.dart';
import 'package:rotary/data/models/notification/notification_response.dart';
import 'package:rotary/presentation/common_widgets/common_dialog.dart';
import 'package:rotary/presentation/features/notification/notification_bloc.dart';
import 'package:rotary/presentation/pages/events/event_detail_page.dart';
import 'package:rotary/presentation/pages/gml/document_viewer.dart';

import '../data/models/notification/notifications_model.dart';

class NotificationPage extends StatefulWidget {
  final NotificationBloc notificationBloc;
  const NotificationPage({Key? key, required this.notificationBloc})
      : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<NotificationModel> notifications = [];
  // List<NotificationModel> readNotifications = [];
  // List<NotificationModel> unreadNotifications = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<NotificationResponseModel>(
        stream: widget.notificationBloc.notificationRx.stream,
        builder: (context, AsyncSnapshot<NotificationResponseModel> snapshot) {
          print(snapshot);
          if (snapshot.hasData) {
            final data = snapshot.data as NotificationResponseModel;
            notifications = data.notifications ?? [];
            // unreadNotifications =
            //     notifications.where((e) => e.readAt == null).toList();
            // readNotifications = notifications
            //     .where((element) => element.readAt != null)
            //     .toList();
          } else if (snapshot.hasError) {
            Fluttertoast.showToast(
              msg: snapshot.error.toString(),
              backgroundColor: Colors.red,
            );
          }
          return Scaffold(
              appBar: AppBar(
                title: const Text('Notifications'),
                // actions: [
                //   notifications.isEmpty
                //       ? SizedBox()
                //       : TextButton(
                //           onPressed: () {
                //             widget.notificationBloc.add(MarkAllReadEvent());
                //           },
                //           child: Text(
                //             "Mark all read",
                //             style: TextStyle(color: Colors.white, fontSize: 10),
                //           ),
                //         )
                // ],
              ),
              body: Stack(
                children: [
                  // notifications.isEmpty
                  //     ? Center(
                  //         child: Text(
                  //           'No new Notifications',
                  //           style: TextStyle(fontSize: 14),
                  //         ),
                  //       )
                  //     :
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NotificationCategoryWidget(
                            notifications: notifications,
                            notificationBloc: widget.notificationBloc,
                          ),
                          // NotificationCategoryWidget(
                          //   notifications: readNotifications,
                          //   notificationBloc: widget.notificationBloc,
                          //   category: "Read Notifications",
                          // )
                        ],
                      ),
                    ),
                  ),
                  snapshot.connectionState == ConnectionState.waiting
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : SizedBox()
                ],
              ));
        });
  }
}

class NotificationCategoryWidget extends StatelessWidget {
  final List<NotificationModel> notifications;
  final NotificationBloc notificationBloc;
  final List<String> imageFiletype = ['png', 'jpg', 'jpeg'];
  NotificationCategoryWidget({
    Key? key,
    required this.notifications,
    required this.notificationBloc,
  }) : super(key: key);

  String timeAgo(String d) {
    DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateTime dateTime = format.parse(d);
    Duration diff = DateTime.now().difference(dateTime);
    if (diff.inDays > 365)
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    if (diff.inDays > 30)
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    if (diff.inDays > 7)
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    if (diff.inDays > 0)
      return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
    if (diff.inHours > 0)
      return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
    if (diff.inMinutes > 0)
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
    return "just now";
  }

  String formatTimestamp(String d) {
    String formattedTimeOrDate;
    DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateTime timestamp = format.parse(d);

    final today = DateTime.now();
    final yesterday = today.subtract(Duration(days: 1));

    if (timestamp.year == today.year &&
        timestamp.month == today.month &&
        timestamp.day == today.day) {
      formattedTimeOrDate =
          DateFormat.jm().format(timestamp); // "h:mm a" format
    } else if (timestamp.year == yesterday.year &&
        timestamp.month == yesterday.month &&
        timestamp.day == yesterday.day) {
      formattedTimeOrDate = "Yesterday";
    } else {
      formattedTimeOrDate =
          DateFormat.yMd().format(timestamp); // "MM/dd/yyyy" format
    }

    return formattedTimeOrDate;
  }

  _buildLeading(
    NotificationModel notification,
  ) {
    String? type = notification.notification?.fileType;
    if (type == null) {
      return Text(
        notification.notification?.title?.characters.first ?? "N",
        style: AppStyles.kBB20.copyWith(
            color: notification.readAt == null ? Colors.black : Colors.black54),
      );
    } else if (type.toLowerCase() == 'pdf') {
      return Icon(Icons.file_present,
          color: notification.readAt == null ? Colors.black : Colors.black54);
    } else if (imageFiletype.contains(type)) {
      return Icon(Icons.image,
          color: notification.readAt == null ? Colors.black : Colors.black54);
    } else {
      return Image.asset(
        "assets/images/events.png",
        color: AppColors.rotaryBlue,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   category,
        //   style: AppStyles.kBB18,
        // ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(top: 10),
          itemCount: notifications.length,
          // separatorBuilder: (context, index) =>
          //     SizedBox(height: 10),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                if (notifications[index].readAt == null) {
                  notificationBloc
                      .add(MarkReadEvent(notifications[index].nId ?? ""));
                }
                if (notifications[index].notification?.filePath == null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventDetailsPage(
                          id: notifications[index].notification?.id ?? ""),
                    ),
                  );
                } else if (notifications[index].notification?.fileType ==
                    'pdf') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DocumentViewer(
                              filePath:
                                  notifications[index].notification?.filePath ??
                                      "",
                              title: notifications[index].notification?.title ??
                                  "")));
                } else if (imageFiletype
                    .contains(notifications[index].notification?.fileType)) {
                  showCommonDialog(context,
                      notifications[index].notification?.filePath ?? "");
                }
              },
              child: Container(
                height: 80,
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    // CircleAvatar(radius: 3, backgroundColor: notifications[index].readAt == null ? AppColors.rotaryBlue: Colors.white,),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                        alignment: Alignment.center,
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // border: Border.all(color: AppColors.BorderColor),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                        child: _buildLeading(notifications[index])

                        // Icon(
                        //   Icons.message,
                        //   size: 20,
                        //   color: AppColors.rotaryBlue,
                        // ),
                        ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${notifications[index].notification?.title}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.kBB16.copyWith(
                                color: notifications[index].readAt == null
                                    ? Colors.black
                                    : Colors.black54,
                                fontWeight: notifications[index].readAt == null
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          ),
                          Flexible(
                            child: Text(
                              "${notifications[index].notification?.description}",
                              style: AppStyles.kG12.copyWith(
                                  color: notifications[index].readAt == null
                                      ? Colors.black
                                      : Colors.black54,
                                  fontWeight:
                                      notifications[index].readAt == null
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(
                      formatTimestamp(
                        notifications[index].createdAt ?? "",
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.kBB14.copyWith(
                          color: notifications[index].readAt == null
                              ? Colors.black
                              : Colors.black54,
                          fontWeight: notifications[index].readAt == null
                              ? FontWeight.bold
                              : FontWeight.normal),
                    ),
                    // IconButton(
                    //     onPressed: () {
                    //       DialogUtils.showBottomDialog(
                    //         context,
                    //         "${notifications[index].notification?.title ?? ""}",
                    //         [
                    //           TextButton(
                    //             onPressed: () {
                    //               Navigator.pop(context);
                    //               notificationBloc.add(
                    //                   MarkReadEvent(notifications[index].nId!));
                    //             },
                    //             child: Text("Mark as read"),
                    //           )
                    //         ],
                    //         titleTextStyle: TextStyle(
                    //           color: Colors.black,
                    //           fontSize: 12,
                    //           fontFamily: "Poppins",
                    //           fontWeight: FontWeight.w600,
                    //         ),
                    //       );
                    //     },
                    //     icon: Icon(Icons.more_horiz))
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
