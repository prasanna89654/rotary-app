import 'package:rotary/core/resources/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserLocalDataSources {
  Future<bool> isLoggedIn();
  Future<bool> saveUserLoggedIn();
  Future<bool> saveUserToken(String token);
  Future<void> saveUserImage(String image);
  Future<void> saveUserName(String name);
  Future<void> saveUserId(String id);
  Future<void> clearUserToken();
  Future<void> clearUserAsLogin();
  Future<void> clearUserImage();
  Future<void> clearUserName();
  Future<void> clearUserId();
  Future<String> getUserToken();
  Future<String> getUserId();
  Future<String> getUserImage();
  Future<String> getUserName();
}

class UserLocalDataSourcesImpl implements UserLocalDataSources {
  final SharedPreferences sharedPreferences;

  UserLocalDataSourcesImpl({required this.sharedPreferences});

  @override
  Future<bool> isLoggedIn() async {
    return await sharedPreferences.getBool(AppConstant.prefLoggedIn) ?? false;
  }

  @override
  Future<bool> saveUserLoggedIn() async {
    return await sharedPreferences.setBool(AppConstant.prefLoggedIn, true);
  }

  @override
  Future<bool> saveUserToken(String token) async =>
      await sharedPreferences.setString(AppConstant.prefToken, token);

  @override
  Future<void> clearUserAsLogin() =>
      sharedPreferences.remove(AppConstant.prefLoggedIn);

  @override
  Future<void> clearUserToken() {
    return sharedPreferences.remove(AppConstant.prefToken);
  }

  @override
  Future<void> clearUserId() {
    return sharedPreferences.remove(AppConstant.prefUserId);
  }

  @override
  Future<void> clearUserImage() {
    return sharedPreferences.remove(AppConstant.prefUserImage);
  }

  @override
  Future<void> clearUserName() {
    return sharedPreferences.remove(AppConstant.prefUserName);
  }

  @override
  Future<void> saveUserId(String id) {
    return sharedPreferences.setString(AppConstant.prefUserId, id);
  }

  @override
  Future<void> saveUserImage(String image) {
    return sharedPreferences.setString(AppConstant.prefUserImage, image);
  }

  @override
  Future<void> saveUserName(String name) {
    return sharedPreferences.setString(AppConstant.prefUserName, name);
  }

  @override
  Future<String> getUserId() async {
    return await sharedPreferences.getString(AppConstant.prefUserId) ?? "";
  }

  @override
  Future<String> getUserImage() async {
    return await sharedPreferences.getString(AppConstant.prefUserImage) ?? "";
  }

  @override
  Future<String> getUserName() async {
    return await sharedPreferences.getString(AppConstant.prefUserName) ?? "";
  }

  @override
  Future<String> getUserToken() async {
    return await sharedPreferences.getString(AppConstant.prefToken) ?? "";
  }
}
