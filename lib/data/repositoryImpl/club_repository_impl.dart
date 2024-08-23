import 'package:rotary/core/network/network_info.dart';
import 'package:rotary/data/data_sources/club/club_remote_data_sources.dart';
import 'package:rotary/data/data_sources/user/user_local_data_sources.dart';
import 'package:rotary/data/models/club/club_details_model/club_details_response_model.dart';
import 'package:rotary/data/models/club/club_details_model/club_details_request_model.dart';
import 'package:rotary/domain/entities/club/club.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:rotary/domain/repository/club_repository/club_repository.dart';

class ClubRepositoryImpl implements ClubRepository {
  final ClubRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final UserLocalDataSources userLocalDataSources;

  ClubRepositoryImpl(
      {required this.remoteDataSource,
      required this.networkInfo,
      required this.userLocalDataSources});

  @override
  Future<Either<Failure, Clubs>> getClubs() async {
    // if (await networkInfo.isConnected) {
    try {
      final result = await remoteDataSource.getClubs();
      return Right(result);
    } catch (e) {
      return Left(parseFailure(e));
    }
    // } else {
    //   return Left(NetworkFailure());
    // }
  }

  @override
  Future<Either<Failure, ClubDetailsResponseModel>> getClubDetails(
      ClubDetailsRequestModel clubDetailsRequestModel) async {
    // if (await networkInfo.isConnected) {
    try {
      final token = await userLocalDataSources.getUserToken();
      final result =
          await remoteDataSource.getClubDetails(token, clubDetailsRequestModel);

      return Right(result);
    } catch (e) {
      return Left(parseFailure(e));
    }
    // } else {
    //   return Left(NetworkFailure());
    // }
  }
}
