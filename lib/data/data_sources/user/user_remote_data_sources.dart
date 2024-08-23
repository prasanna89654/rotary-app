import 'package:dio/dio.dart';
import 'package:rotary/core/error/exceptions.dart';
import 'package:rotary/core/network/network_utils.dart';
import 'package:rotary/core/resources/app_url.dart';
import 'package:rotary/data/models/login/login_response.dart';

abstract class UserRemoteDataSource {
  Future<void> logOut(String token);
  Future<LoginResponse> login(String email, String password);
  Future<String> changePassword(
      String token, String currentPassword, String newPassword);

  Future<void> forgotPassword(String token, String email);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  NetworkUtil networkUtil;
  UserRemoteDataSourceImpl({required this.networkUtil});
  @override
  Future<LoginResponse> login(String email, String password) async {
    try {
      Response response = await networkUtil.postQueryParams(
          AppUrl.BASE_URL + AppUrl.LOGIN,
          data: {'username': email, 'password': password});

      return LoginResponse.fromJson(networkUtil.parseNormalResponse(response));
    } catch (e) {
      print(e);
      throw throwException(e);
    }
  }

  @override
  Future<String> changePassword(
      String token, String currentPassword, String newPassword) async {
    try {
      print("token: $token");
      Response response = await networkUtil.postQueryParams(
        AppUrl.BASE_URL + AppUrl.CHANGE_PASSWORD,
        token: token,
        data: {
          'current_password': currentPassword,
          'password': newPassword,
          'password_confirmation': newPassword
        },
      );
      print("response: ${response.headers}");
      print(response);
      return response.data['message'];
    } catch (e) {
      print(e);
      throw throwException(e);
    }
  }

  @override
  Future<bool> forgotPassword(String token, String newEmail) async {
    try {
      print("token: $token");
      Response response = await networkUtil.postQueryParams(
        AppUrl.BASE_URL + AppUrl.FORGOT_PASSWORD,
        token: token,
        data: {
          'email': newEmail,
        },
      );
      print("response: ${response.headers}");
      print(response);
      return true;
    } catch (e) {
      print(e);
      throw throwException(e);
    }
  }

  @override
  Future<void> logOut(String token) async {
    try {
      Response response = await networkUtil
          .postQueryParams(AppUrl.BASE_URL + AppUrl.LOGOUT, token: token);
      networkUtil.parseNormalResponse(response);
    } catch (e) {
      print(e);
      throw throwException(e);
    }
  }
}
