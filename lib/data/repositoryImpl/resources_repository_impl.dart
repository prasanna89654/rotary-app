import 'package:rotary/core/network/network_info.dart';
import 'package:rotary/data/data_sources/resources/resources_remote_data_sources.dart';
import 'package:rotary/data/models/resources/resource_description_model.dart';
import 'package:rotary/data/models/resources/resource_details/resources_detail_response_model.dart';
import 'package:rotary/data/models/resources/resources_model.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:rotary/domain/repository/resources_repository/resources_repository.dart';

class ResourcesRepositoryImpl implements ResourcesRepository {
  NetworkInfo networkInfo;
  ResourcesRemoteDataSource resourcesRemoteDataSource;
  ResourcesRepositoryImpl(
      {required this.networkInfo, required this.resourcesRemoteDataSource});
  @override
  Future<Either<Failure, List<ResourcesModel>>> getResources() async {
    // if (await networkInfo.isConnected) {
    try {
      final result = await resourcesRemoteDataSource.getResources();
      return Right(result);
    } catch (e) {
      return Left(parseFailure(e));
    }
    // } else {
    //   return Left(NetworkFailure());
    // }
  }

  @override
  Future<Either<Failure, ResourcesDetailResponseModel>> getResourceDetails(
      String id) async {
    // if (await networkInfo.isConnected) {
    try {
      final result = await resourcesRemoteDataSource.getResourceDetails(id);
      return Right(result);
    } catch (e) {
      return Left(parseFailure(e));
    }
    // } else {
    //   return Left(NetworkFailure());
    // }
  }

  @override
  Future<Either<Failure, ResourceDescriptionModel>> getResourceDescription(
      String id) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await resourcesRemoteDataSource.getResourceDescription(id);
        return Right(result);
      } catch (e) {
        return Left(parseFailure(e));
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
