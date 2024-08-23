import 'package:rotary/core/network/network_info.dart';
import 'package:rotary/data/data_sources/district_committee/district_committee_remote_data_sources.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:rotary/domain/repository/district_committee_repository/district_committee_repository.dart';

import '../models/district_committee/district_committee_response_model.dart';

class DistrictCommitteeRepositoryImpl implements DistrictCommitteeRepository {
  NetworkInfo networkInfo;
  DistrictCommitteeRemoteDataSource districtCommitteeRemoteDataSource;
  DistrictCommitteeRepositoryImpl(
      {required this.networkInfo,
      required this.districtCommitteeRemoteDataSource});
  @override
  Future<Either<Failure, DistrictComitteeResponseModel>>
      getDistrictCommittee() async {
    // if (await networkInfo.isConnected) {
    try {
      final result =
          await districtCommitteeRemoteDataSource.getDistrictCommittee();
      return Right(result);
    } catch (e) {
      return Left(parseFailure(e));
    }
    // } else {
    //   return Left(NetworkFailure());
    // }
  }
}
