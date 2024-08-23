
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';

///Package imports
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rotary/core/resources/app_strings.dart';
import 'package:rotary/data/models/calendar_event/calendar_event_model.dart';
import 'package:rotary/presentation/features/calendar_bloc/calendar_bloc.dart';
import 'package:rotary/presentation/pages/events/event_detail_page.dart';

///calendar import
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../core/injection/injection_container.dart';
import '../../core/utils/com_fun.dart';

class DgNewCalendar extends StatefulWidget {
  const DgNewCalendar({Key? key}) : super(key: key);

  @override
  State<DgNewCalendar> createState() => _DgNewCalendarState();
}

class _DgNewCalendarState extends State<DgNewCalendar> {
  late CalendarBloc _calendarBloc;

  @override
  void initState() {
    super.initState();
    _calendarBloc = CalendarBloc(di());
    _calendarBloc.add(LoadCalendarAllEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dg Calendar'.toUpperCase()),
      ),
      body: DGNewCalendarBody(),
    );
  }
}

class DGNewCalendarBody extends StatelessWidget {
  const DGNewCalendarBody({
    Key? key,
    // required CalendarBloc calendarBloc,
  }) : super(key: key);

  // final CalendarBloc _calendarBloc;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        BlocProvider.of<CalendarBloc>(context).add(LoadCalendarAllEvent());
        return Future.value(true);
      },
      child: BlocBuilder<CalendarBloc, CalendarState>(
        builder: (context, state) {
          if (state is CalendarInitial || state is CalendarLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CalendarError) {
            print(state.message);
            return Center(
              child: Text(state.message),
            );
          }

          if (state is CalendarLoaded) {
            // DateTime now = DateTime.now().subtract(Duration(days: 1));
            // DateTime nowFormatted = DateTime(now.year, now.month, now.day);
            // var previousEvent = CalendarEventModel(
            //   id: "eyJpdiI6IjU0VS9PZ3h6TEU0aTJTVG9hR1N1bmc9PSIsInZhbHVlIjoiSmNIYmE2MnIzZFF6S3dpNUZLWThLUT09IiwibWFjIjoiY2JhZjhmOWVmYzc4YWQ2ZjM2OGI0NWQxMTE1ZThmZTFjYmI0MzdlZTc2MWUyMjU4MWQzNzUwMGM2ZDY2MjU3MiIsInRhZyI6IiJ90",
            //   title: "Event 1",
            //   date: nowFormatted,
            //   location: "KAthmandu",
            // );
            // print("Previous Event: ${previousEvent.date}");
            // state.calendarEventModels.insert(0, previousEvent);

            return AgendaViewCalendar(state.calendarEventModels);
          }
          // this never gets called if it is called then there is any issue in the code
          return Container();
        },
      ),
    );
  }
}

/// Widget of the AgendaView Calendar.
class AgendaViewCalendar extends StatefulWidget {
  final List<CalendarEventModel> eventList;

  const AgendaViewCalendar(this.eventList);

  @override
  State<AgendaViewCalendar> createState() => _AgendaViewCalendarState();
}

class _AgendaViewCalendarState extends State<AgendaViewCalendar> {
  late _MeetingDataSource _events;
  final CalendarController _calendarController = CalendarController();
  List<dynamic> meetings = [];
  // late Orientation _deviceOrientation;

  @override
  void initState() {
    DateTime now = DateTime.now();
    DateTime nowFormatted = DateTime(now.year, now.month, now.day);
    print(widget.eventList);
    _calendarController.selectedDate = nowFormatted;
    // print("initState SelectedDate ${_calendarController.selectedDate}");
    _events = _MeetingDataSource(_getAppointments());
    getFirstDayMeeting();
    // print("initState meetings ${meetings}");

    super.initState();
  }

  getFirstDayMeeting() {
    widget.eventList.forEach((element) {
      if (element.date == _calendarController.selectedDate) {
        meetings.add(_Meeting(
          element.title,
          Colors.red,
          "",
          element.date,
          element.date,
        ));
      }
    });
    return meetings;
  }

  @override
  Widget build(BuildContext context) {
    // print("Month test" + getMonthName(_calendarController.selectedDate!));
    print(meetings);
    final Widget calendar = Theme(
        data: ThemeData(),
        child: MouseRegion(
          onHover: (PointerHoverEvent event) {
            // CalendarDetails? details = _calendarController
            //     .getCalendarDetailsAtOffset!(event.localPosition);

            // this.details = details?.appointments!;
          },
          child: _getAgendaViewCalendar(
              _events, _onViewChanged, _calendarController),
        ));

    return Scrollbar(
      child: ListView(
        children: <Widget>[
          Card(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Container(
                // color: AppColors.appBackgroundColor,
                height: 400,
                child: calendar,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 16, right: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  color: AppColors.rotaryBlue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${_calendarController.selectedDate!.day.toString()}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: AutoSizeText(
                          "${getMonthName(_calendarController.selectedDate!)}",
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: meetings.isEmpty
                      ? Container(
                          // padding: const EdgeInsets.all(10),
                          alignment: Alignment.centerLeft,
                          height: 60,
                          child: Text(
                            "No events",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          itemCount: meetings.length,
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 10,
                            );
                          },
                          itemBuilder: (context, index) {
                            int index2 = widget.eventList.indexWhere(
                                (element) =>
                                    element.title == meetings[index].eventName);
                            String location = widget.eventList[index2].location;
                            print(location);
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EventDetailsPage(
                                      id: widget.eventList[index2].id,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                color: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                height: 60,
                                // color: AppColors.rotaryBlue,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      "${meetings[index].eventName}",
                                      maxLines: 1,
                                      minFontSize: 10,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        // color: Colors.white,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          size: 15,
                                          color: AppColors.rotaryGold,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "${location}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            // color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Method that creates the collection the data source for calendar, with
  /// required information.
  List<_Meeting> _getAppointments() {
    /// Creates the required appointment subject details as a list.

    /// Creates the required appointment color details as a list.
    final List<Color> colorCollection = <Color>[];
    colorCollection.add(AppColors.rotaryBlue);
    colorCollection.add(Colors.grey);

    final List<_Meeting> meetings = <_Meeting>[];
    // final Random random = Random();
    final DateTime rangeStartDate = widget.eventList[0].date;
    print(rangeStartDate);
    final DateTime endDate = widget.eventList[widget.eventList.length - 1].date;
    print("End Date $endDate");
    final dat = Duration(
        days: widget.eventList.last.date.difference(rangeStartDate).inDays);
    print("dat is $dat");
    final DateTime rangeEndDate = rangeStartDate.add(Duration(
        days: widget.eventList.last.date.difference(rangeStartDate).inDays));
    print(rangeEndDate);
    print(widget.eventList.length);
    print("range end date: $rangeEndDate");
    DateTime todayDate = DateTime.now();
    DateTime formattedDate =
        DateTime(todayDate.year, todayDate.month, todayDate.day);
    print("today date: $todayDate");
    print("formattedDate $formattedDate");
    for (DateTime i = rangeStartDate;
        i.isBefore(rangeEndDate) || i.isAtSameMomentAs(rangeEndDate);
        i = i.add(Duration(days: 1))) {
      // print("First loop $i");

      widget.eventList.forEach((element) {
        // print("element.date ${element.date}");
        // print("i ${i}");
        // // print(element.date == i);
        // print(element.date.isAtSameMomentAs(i));
        if (element.date.isAtSameMomentAs(i)) {
          print("Found a match");
          meetings.add(
            _Meeting(
              element.title,
              element.date.isBefore(formattedDate)
                  ? colorCollection[1]
                  : colorCollection[0],
              "",
              element.date,
              element.date,
            ),
          );
        }
      });
    }

    return meetings;
  }

  /// Updated the selected date of calendar, when the months swiped, selects the
  /// current date when the calendar displays the current month, and selects the
  /// first date of the month for rest of the months.
  void _onViewChanged(ViewChangedDetails visibleDatesChangedDetails) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final DateTime currentViewDate = visibleDatesChangedDetails
          .visibleDates[visibleDatesChangedDetails.visibleDates.length ~/ 2];
      if (currentViewDate.month == DateTime.now().month &&
          currentViewDate.year == DateTime.now().year) {
        _calendarController.selectedDate = DateTime.now();
      } else {
        _calendarController.selectedDate =
            DateTime(currentViewDate.year, currentViewDate.month);
        // }
      }
    });
  }

  /// Returns the calendar widget based on the properties passed.
  SfCalendar _getAgendaViewCalendar(
      [CalendarDataSource? calendarDataSource,
      ViewChangedCallback? onViewChanged,
      CalendarController? controller]) {
    return SfCalendar(
      view: CalendarView.month,
      onTap: (CalendarTapDetails details) {
        if (details.appointments != null) {
          setState(() {
            meetings = details.appointments!;
          });
        }
      },
      controller: controller,
      showDatePickerButton: true,
      showNavigationArrow: true,
      dataSource: calendarDataSource,
      onViewChanged: (details) {
        print(details);
      },
      // monthCellBuilder: (context, details) {
      //   return Container();
      // },
      monthViewSettings: MonthViewSettings(
        showTrailingAndLeadingDates: false,
        showAgenda: false,
        numberOfWeeksInView: 6,
        appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
      ),
      timeSlotViewSettings: const TimeSlotViewSettings(
          minimumAppointmentDuration: Duration(minutes: 60)),
    );
  }
}

/// An object to set the appointment collection data source to collection, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class _MeetingDataSource extends CalendarDataSource {
  _MeetingDataSource(this.source);

  List<_Meeting> source;

  @override
  List<_Meeting> get appointments => source;

  @override
  DateTime getStartTime(int index) {
    return source[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return source[index].to;
  }

  // @override
  // String getSubject(int index) {
  //   return source[index].;
  // }

  @override
  String getSubject(int index) {
    return source[index].eventName;
  }

  // @override
  // String? getStartTimeZone(int index) {
  //   return source[index].location;
  // }

  @override
  String getEndTimeZone(int index) {
    return "";
  }

  @override
  Color getColor(int index) {
    return source[index].background;
  }

  // @override
  // String? getRecurrenceRule(int index) {
  //   return source[index].recurrenceRule;
  // }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class _Meeting {
  _Meeting(
    this.eventName,
    this.background,
    this.endTimeZone,
    this.from,
    this.to,
  );
  DateTime from;
  DateTime to;
  String eventName;
  Color background;
  String? endTimeZone;
}
