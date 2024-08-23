
import 'package:dio/dio.dart';
import 'package:rotary/core/error/exceptions.dart';
import 'package:rotary/core/network/network_utils.dart';
import 'package:rotary/core/resources/app_url.dart';
import 'package:rotary/data/models/business_directory/ads/business_directory_ads_model.dart';
import 'package:rotary/data/models/business_directory/business_directory.dart';

abstract class DirectoryRemoteDataSource {
  Future<List<BusinessDirectory>> getDirectoryDaata();
  Future<List<String>> getDistricts();
  Future<List<BusinessAdsModel>> getAds();
}

class DirectoryRemoteDataSourceImpl extends DirectoryRemoteDataSource {
  final NetworkUtil _networkUtil;

  DirectoryRemoteDataSourceImpl({required NetworkUtil networkUtil})
      : _networkUtil = networkUtil;
  @override
  Future<List<BusinessDirectory>> getDirectoryDaata() async {
    try {
      final Response response =
          await _networkUtil.get(AppUrl.BASE_URL + AppUrl.BUSINESS_DIRECTORY);
      List<BusinessDirectory> bd =
          List.from(_networkUtil.parseNormalResponse2(response))
              .map((e) => BusinessDirectory.fromJson(e))
              .toList();
      return bd;
    } catch (e) {
      throw throwException(e);
    }
  }

  @override
  Future<List<String>> getDistricts() async {
    try {
      final  Response response = await _networkUtil
          .get(AppUrl.BASE_URL + AppUrl.GET_BUSINESS_DIRECTORY_DISTRICTS);
      final parsedData = response.data;
      return parsedData;
    } catch (e) {
      throw throwException(e);
    }
  }
  
  @override
  Future<List<BusinessAdsModel>> getAds() async {
    try {
      final response = await _networkUtil.get(AppUrl.BASE_URL + AppUrl.BUSINESS_DIRECTORY_ADS);
      List<BusinessAdsModel> bda =
          List.from(_networkUtil.parseNormalResponse2(response))
              .map((e) => BusinessAdsModel.fromJson(e))
              .toList();
      return bda;
    } catch (e) {
      throw throwException(e);
    }
  }
}
