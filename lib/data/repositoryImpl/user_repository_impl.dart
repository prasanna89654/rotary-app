import 'package:dartz/dartz.dart';
import 'package:rotary/core/error/exceptions.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:rotary/core/network/network_info.dart';
import 'package:rotary/data/data_sources/user/user_local_data_sources.dart';
import 'package:rotary/data/models/login/login_response.dart';
import 'package:rotary/domain/repository/user_repository.dart';

import '../data_sources/user/user_remote_data_sources.dart';

class UserRepositoryImpl implements UserRepository {
  NetworkInfo networkInfo;
  UserRemoteDataSource userRemoteDataSource;
  UserLocalDataSources userLocalDataSources;
  UserRepositoryImpl({
    required this.networkInfo,
    required this.userRemoteDataSource,
    required this.userLocalDataSources,
  });
  @override
  Future<Either<Failure, LoginResponse>> login(
      String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await userRemoteDataSource.login(email, password);
        String userName =
            "${result.user?.firstname ?? ""} ${result.user?.middlename ?? ""} ${result.user?.lastname ?? ""}";
        await userLocalDataSources
          ..saveUserLoggedIn()
          ..saveUserToken(result.token ?? "")
          ..saveUserId(result.user?.memberId ?? "")
          ..saveUserImage(result.image ?? "")
          ..saveUserName(userName);
        return Right(result);
      } catch (e) {
        print(e);
        return Left(parseFailure(e));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<void> logOut() async {
    try {
      final token = await userLocalDataSources.getUserToken();
      await userRemoteDataSource.logOut(token);
      await userLocalDataSources
        ..clearUserAsLogin()
        ..clearUserToken()
        ..clearUserId()
        ..clearUserImage()
        ..clearUserName();
    } catch (e) {
      parseFailure(e);
      if (e is UnAuthorizedException) {
        await userLocalDataSources
          ..clearUserAsLogin()
          ..clearUserToken()
          ..clearUserId()
          ..clearUserImage()
          ..clearUserName();
      }
      print(e);
    }
  }

  @override
  Future<Either<Failure, String>> changePassword(
      String currentPassword, String newPassword) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await userLocalDataSources.getUserToken();
        final result = await userRemoteDataSource.changePassword(
            token, currentPassword, newPassword);
        return Right(result);
      } catch (e) {
        return Left(parseFailure(e));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> forgotPassword(String email) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await userLocalDataSources.getUserToken();
        await userRemoteDataSource.forgotPassword(token, email);
        return Right(true);
      } catch (e) {
        return Left(parseFailure(e));
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
