import 'package:rotary/core/network/network_info.dart';
import 'package:rotary/data/data_sources/home/homepage_remote_data_sources.dart';
import 'package:rotary/data/models/home/home_model.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:rotary/domain/repository/home_repository/home_repository.dart';

import '../data_sources/user/user_local_data_sources.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomePageRemoteDataSource homePageRemoteDataSource;
  final UserLocalDataSources userLocalDataSources;
  NetworkInfo networkInfo;
  HomeRepositoryImpl(
      {required this.networkInfo,
      required this.homePageRemoteDataSource,
      required this.userLocalDataSources});
  @override
  Future<Either<Failure, HomeModel>> getHomePageData() async {
    // if (await networkInfo.isConnected) {
    try {
      final token = await userLocalDataSources.getUserToken();
      final result = await homePageRemoteDataSource.getHomePageData(token);
      print(result.toString());
      return Right(result);
    } catch (e) {
      return Left(parseFailure(e));
    }
    // } else {
    //   return Left(NetworkFailure());
    // }
  }
}
