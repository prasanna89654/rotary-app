import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rotary/core/network/network_utils.dart';
import 'package:rotary/data/models/profile/profile_model.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/resources/app_url.dart';
import '../../models/profile/update_profile_request_model.dart';

abstract class ProfileRemoteDataSources {
  Future<ProfileModel> getProfile(String token);
  Future<bool> updateProfileData(
      String token, UpdateProfileRequestModel userData);
}

class ProfileRemoteDataSourcesImpl implements ProfileRemoteDataSources {
  NetworkUtil networkUtil;
  ProfileRemoteDataSourcesImpl({required this.networkUtil});
  @override
  Future<ProfileModel> getProfile(String token) async {
    try {
      print("token: " + token);
      Response response =
          await networkUtil.get(AppUrl.BASE_URL + AppUrl.PROFILE, token: token);
      log(response.toString());
      return ProfileModel.fromJson(networkUtil.parseNormalResponse(response));
    } catch (e) {
      print(e);
      throw throwException(e);
    }
  }

  @override
  Future<bool> updateProfileData(
      String token, UpdateProfileRequestModel userData) async {
    try {
      print("token: " + token);
      FormData formData;
      if (userData.image == null) {
        formData = FormData.fromMap({
          "firstname": userData.firstname,
          "email": userData.email,
          "phone_no": userData.phoneNo,
          "city": userData.city,
          "lastname": userData.lastname,
          "middlename": userData.middlename,
          "address": userData.address,
          "classification": userData.classification
        });
      } else {
        formData = FormData.fromMap({
          "firstname": userData.firstname,
          "email": userData.email,
          "phone_no": userData.phoneNo,
          "city": userData.city,
          "lastname": userData.lastname,
          "middlename": userData.middlename,
          "address": userData.address,
          "classification": userData.classification,
          "image": await MultipartFile.fromFile(userData.image!.path,
              filename: userData.image!.path.split('/').last)
        });
      }

      formData.fields.forEach((e) {
        print("key: ${e.key}");
        print("value: ${e.value}");
      });

      Response response = await networkUtil.postQueryParams(
          AppUrl.BASE_URL + AppUrl.UPDATE_PROFILE,
          token: token,
          formData: formData);
      print(response.toString());
      return true;
    } catch (e) {
      // if(e is DioError) {
      //    e.response?.data["errors"]["email"][0];
      // }
      print(e);
      throw throwException(e);
    }
  }
}

parseError() {}
