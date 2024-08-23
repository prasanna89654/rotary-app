import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rotary/core/error/exceptions.dart';
import 'package:rotary/core/network/network_utils.dart';
import 'package:rotary/data/models/district_governors/district_governor_detail_model/district_governor_detail_model..dart';
import 'package:rotary/data/models/district_governors/district_governor_response_model.dart';

import '../../../core/resources/app_url.dart';

abstract class DistrictGovernorRemoteDataSource {
  Future<DistrictGovernorResponseModel> getAllDistrictGovernors();
  Future<DistrictGovernorDetailModel> getDistrictGovernorDetail(String id);
}

class DistrictGovernorRemoteDataSourceImpl
    implements DistrictGovernorRemoteDataSource {
  final NetworkUtil networkUtil;

  DistrictGovernorRemoteDataSourceImpl({required this.networkUtil});
  @override
  Future<DistrictGovernorResponseModel> getAllDistrictGovernors() async {
    try {
      Response response =
          await networkUtil.get(AppUrl.BASE_URL + AppUrl.DISTRICT_GOVERNORS);
      DistrictGovernorResponseModel districtGovernorResponseModel =
          DistrictGovernorResponseModel.fromJson(
              networkUtil.parseNormalResponse(response));
      return districtGovernorResponseModel;
    } catch (e) {
      print(e.toString());
      throw throwException(e);
    }
  }

  @override
  Future<DistrictGovernorDetailModel> getDistrictGovernorDetail(
      String id) async {
    try {
      final response = await networkUtil
          .get(AppUrl.BASE_URL + AppUrl.DISTRICT_GOVERNORS_DETAIL + id);
      print(response.realUri.toString());
      print(response.toString());
      DistrictGovernorDetailModel districtGovernorDetailModel =
          DistrictGovernorDetailModel.fromJson(
              networkUtil.parseNormalResponse(response));
      log(districtGovernorDetailModel.toString());
      return districtGovernorDetailModel;
    } catch (e) {
      throw throwException(e);
    }
  }
}
