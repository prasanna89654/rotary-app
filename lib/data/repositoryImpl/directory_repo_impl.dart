import 'package:dartz/dartz.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:rotary/core/network/network_info.dart';
import 'package:rotary/data/data_sources/directory/directory_remote_data_source.dart';
import 'package:rotary/data/models/business_directory/ads/business_directory_ads_model.dart';
import 'package:rotary/data/models/business_directory/business_directory.dart';
import 'package:rotary/domain/repository/directory_repository/directory_repository.dart';

class DirectoryRepoImpl extends DirectoryRepository {
  final DirectoryRemoteDataSource directoryRemoteDataSource;
  final NetworkInfo networkInfo;

  DirectoryRepoImpl(
      {required this.directoryRemoteDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, List<BusinessDirectory>>> getDirectory() async {
    try {
      final result = await directoryRemoteDataSource.getDirectoryDaata();
      return Right(result);
    } catch (e) {
      return Left(parseFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getDistricts() async {
    try {
      final result = await directoryRemoteDataSource.getDistricts();
      return Right(result);
    } catch (e) {
      return Left(parseFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<BusinessAdsModel>>> getAds() async {
    try {
      final result = await directoryRemoteDataSource.getAds();
      return Right(result);
    } catch (e) {
      return Left(parseFailure(e));
    }
  }
}
