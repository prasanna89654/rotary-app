import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String parseDisplayDate(DateTime dateTime) {
  final f = DateFormat.yMMMMEEEEd().format(dateTime);

  return f;
}

String getFormattedDate(DateTime dateTime) {
  DateFormat formattedDate = DateFormat.yMMMd();
  return formattedDate.format(dateTime);
}

String parseHours(DateTime dateTime) {
  final f = DateFormat('hh:mm');
  return f.format(dateTime);
}

String parseHoursAMPM(DateTime dateTime) {
  final f = DateFormat('hh:mm aa');
  return f.format(dateTime);
}

String getMonthName(DateTime date) {
  final f = DateFormat.MMMM();
  print("Month: ${f.format(date)}");
  return f.format(date).substring(0, 3);
}

Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

String? emailValidator(String? email) {
  if (email != null) {
    bool hasmatch = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (hasmatch) {
      return null;
    } else {
      return "Please enter valid email, example@example.com";
    }
  } else {
    return "Please enter your email";
  }
}

String getDayOfWeekName(int dayOfWeek) {
  switch (dayOfWeek) {
    case 1:
      return 'Monday';
    case 2:
      return 'Tuesday';
    case 3:
      return 'Wednesday';
    case 4:
      return 'Thursday';
    case 5:
      return 'Friday';
    case 6:
      return 'Saturday';
    case 7:
      return 'Sunday';
    default:
      return '';
  }
}

DateTime parseTimeStringToDateTime(String timeString) {
  // Use the intl package to parse the time string
  final dateTime = DateFormat('h:mm a').parse(timeString);

  // You might want to set a specific date, for example, today's date
  // In this example, we set it to the current date
  return DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    dateTime.hour,
    dateTime.minute,
  );
}

String? convertToMMMDY(String? date) {
  if (date != null) {
    DateTime dateTime = DateTime.parse(date);

    String formattedDate = DateFormat('MMM d, y').format(dateTime);
    return formattedDate;
  } else {
    return null;
  }
}

bool isTimeInRange(DateTime time, DateTime start, DateTime end) {
  // Check if the current time is within the specified range
  return time.isAfter(start) && time.isBefore(end);
}
// bool checkEmailValid
