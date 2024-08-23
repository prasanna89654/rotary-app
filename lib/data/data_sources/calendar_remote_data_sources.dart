import 'package:dio/dio.dart';
import 'package:rotary/core/error/exceptions.dart';
import 'package:rotary/core/network/network_utils.dart';
import 'package:rotary/core/resources/app_url.dart';
import 'package:rotary/data/models/calendar_event/calendar_event_model.dart';

abstract class CalendarRemoteDataSources {
  Future<List<CalendarEventModel>> loadCalendarAllEvent();
}

class CalendarRemoteDataSourcesImpl implements CalendarRemoteDataSources {
  NetworkUtil networkUtil;
  CalendarRemoteDataSourcesImpl({required this.networkUtil});
  @override
  Future<List<CalendarEventModel>> loadCalendarAllEvent() async {
    try {
      Response response =
          await networkUtil.get(AppUrl.BASE_URL + AppUrl.CALENDAR_EVENT);
      List<CalendarEventModel> allEvents = List<dynamic>.from(
              networkUtil.parseNormalResponse(response)['events'])
          .map((event) => CalendarEventModel.fromJson(event))
          .toList();
      return allEvents;
    } catch (e) {
      throw throwException(e);
    }
  }
}
