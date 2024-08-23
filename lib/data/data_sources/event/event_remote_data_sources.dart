import 'package:dio/dio.dart';
import 'package:rotary/core/error/exceptions.dart';
import 'package:rotary/core/network/network_utils.dart';
import 'package:rotary/core/resources/app_url.dart';
import 'package:rotary/data/models/event/event_details_model/event_details_model.dart';
import 'package:rotary/data/models/event/event_response_model.dart';

abstract class EventRemoteDataSource {
  Future<EventResponseModel> getUpcommingEvent();
  Future<EventDetailsModel> getEventDetails(String id);
}

class EventRemoteDataSourceImpl implements EventRemoteDataSource {
  final NetworkUtil networkUtil;

  EventRemoteDataSourceImpl({required this.networkUtil});

  @override
  Future<EventResponseModel> getUpcommingEvent() async {
    try {
      Response response = await networkUtil.get(AppUrl.BASE_URL + AppUrl.EVENT);

      EventResponseModel eventResponseModel = EventResponseModel.fromJson(
          networkUtil.parseNormalResponse2(response));
      return eventResponseModel;
    } catch (e) {
      print(e);
      throw throwException(e);
    }
  }

  @override
  Future<EventDetailsModel> getEventDetails(String id) async {
    try {
      Response response =
          await networkUtil.get(AppUrl.BASE_URL + AppUrl.EVENT_DETAILS + id);
      EventDetailsModel eventDetailsModel =
          EventDetailsModel.fromJson(networkUtil.parseNormalResponse(response));
      return eventDetailsModel;
    } catch (e) {
      throw throwException(e);
    }
  }
}
