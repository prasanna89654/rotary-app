import 'package:rotary/core/error/exceptions.dart';
import 'package:rotary/core/error/failure.dart';

import 'package:dartz/dartz.dart';
import 'package:rotary/core/network/network_info.dart';
import 'package:rotary/data/data_sources/profile/profile_remote_data_sources.dart';
import 'package:rotary/data/data_sources/user/user_local_data_sources.dart';
import 'package:rotary/data/models/profile/profile_model.dart';
import 'package:rotary/domain/repository/user_repository.dart';

import '../../domain/repository/profile_repository.dart';
import '../models/profile/update_profile_request_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRemoteDataSources profileRemoteDataSources;
  UserLocalDataSources userLocalDataSources;
  UserRepository userRepository;
  NetworkInfo networkInfo;
  ProfileRepositoryImpl({
    required this.networkInfo,
    required this.profileRemoteDataSources,
    required this.userLocalDataSources,
    required this.userRepository,
  });
  @override
  Future<Either<Failure, ProfileModel>> getProfile() async {
    // if (await networkInfo.isConnected) {
    try {
      final token = await userLocalDataSources.getUserToken();
      final result = await profileRemoteDataSources.getProfile(token);
      return Right(result);
    } catch (e) {
      if (e is UnAuthorizedException) {
        await userRepository.logOut();
      }
      return Left(parseFailure(e));
    }
    // } else {
    //   return Left(NetworkFailure());
    // }
  }

  @override
  Future<Either<Failure, bool>> updateProfile(
      UpdateProfileRequestModel userData) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await userLocalDataSources.getUserToken();
        final result =
            await profileRemoteDataSources.updateProfileData(token, userData);
        if (result == true) {
          final username = userData.firstname +
              " " +
              userData.middlename +
              " " +
              userData.lastname;
          final image = userData.image == null ? null : userData.image!.path;
          if (image != null) {
            await userLocalDataSources.saveUserImage(image);
          }
          await userLocalDataSources
            ..saveUserName(username);
        }
        return Right(result);
      } catch (e) {
        if (e is UnAuthorizedException) {
          await userRepository.logOut();
        }
        return Left(parseFailure(e));
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
