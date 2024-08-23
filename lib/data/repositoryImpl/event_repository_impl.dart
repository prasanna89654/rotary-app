import 'package:rotary/core/network/network_info.dart';
import 'package:rotary/data/data_sources/event/event_remote_data_sources.dart';
import 'package:rotary/data/models/event/event_details_model/event_details_model.dart';
import 'package:rotary/data/models/event/event_response_model.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:rotary/domain/repository/event_repository/event_repository.dart';

class EventRepositoryImpl extends EventRepository {
  EventRemoteDataSource remoteDataSource;
  NetworkInfo networkInfo;
  EventRepositoryImpl(
      {required this.networkInfo, required this.remoteDataSource});
  @override
  Future<Either<Failure, EventResponseModel>> getUpcommingEvent() async {
    // if (await networkInfo.isConnected) {
    try {
      final result = await remoteDataSource.getUpcommingEvent();
      return Right(result);
    } catch (e) {
      print(e);
      return Left(parseFailure(e));
    }
    // } else {
    //   return Left(NetworkFailure());
    // }
  }

  @override
  Future<Either<Failure, EventDetailsModel>> getEventDetails(String id) async {
    // if (await networkInfo.isConnected) {
    try {
      final result = await remoteDataSource.getEventDetails(id);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure());
    }
    // } else {
    //   return Left(NetworkFailure());
    // }
  }

  @override
  Future<Either<Failure, EventResponseModel>> getCalendarAllEvents() async {
    // if (await networkInfo.isConnected) {
    try {
      final result = await remoteDataSource.getUpcommingEvent();
      return Right(result);
    } catch (e) {
      return Left(parseFailure(e));
    }
    // } else {
    //   return Left(NetworkFailure());
    // }
  }
}
