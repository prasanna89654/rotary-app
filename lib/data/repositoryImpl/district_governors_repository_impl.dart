import 'package:rotary/core/network/network_info.dart';
import 'package:rotary/data/data_sources/district_governor/district_governor_remote_data_sources.dart';
import 'package:rotary/data/models/district_governors/district_governor_detail_model/district_governor_detail_model..dart';
import 'package:rotary/data/models/district_governors/district_governor_response_model.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:rotary/domain/repository/district_governors_repository/district_governors_repository.dart';

class DistrictGovernorRepositoryImpl implements DistrictGovernorRepository {
  final NetworkInfo networkInfo;
  final DistrictGovernorRemoteDataSource districtGovernorRemoteDataSource;
  DistrictGovernorRepositoryImpl(
      {required this.networkInfo,
      required this.districtGovernorRemoteDataSource});
  @override
  Future<Either<Failure, DistrictGovernorResponseModel>>
      getAllDistrictGovernors() async {
    // if (await networkInfo.isConnected) {
    try {
      final result =
          await districtGovernorRemoteDataSource.getAllDistrictGovernors();
      return Right(result);
    } catch (e) {
      return Left(parseFailure(e));
    }
    // } else {
    //   return Left(NetworkFailure());
    // }
  }

  @override
  Future<Either<Failure, DistrictGovernorDetailModel>>
      getDistrictGovernorDetail(String id) async {
    // if (await networkInfo.isConnected) {
    try {
      final result =
          await districtGovernorRemoteDataSource.getDistrictGovernorDetail(id);
      return Right(result);
    } catch (e) {
      return Left(parseFailure(e));
    }
    // } else {
    //   return Left(NetworkFailure());
    // }
  }
}
