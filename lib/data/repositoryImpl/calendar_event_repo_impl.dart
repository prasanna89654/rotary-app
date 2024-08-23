import 'package:rotary/core/network/network_info.dart';
import 'package:rotary/data/data_sources/calendar_remote_data_sources.dart';
import 'package:rotary/data/models/calendar_event/calendar_event_model.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:rotary/domain/repository/calendar_event_repository.dart';

class CalendarEventRepositoryImpl extends CalendarEventRepository {
  final NetworkInfo networkInfo;
  final CalendarRemoteDataSources calendarRemoteDataSources;
  CalendarEventRepositoryImpl(
      {required this.networkInfo, required this.calendarRemoteDataSources});
  @override
  Future<Either<Failure, List<CalendarEventModel>>>
      loadCalendarAllEvent() async {
    // if (await networkInfo.isConnected) {
    try {
      final result = await calendarRemoteDataSources.loadCalendarAllEvent();
      return Right(result);
    } catch (e) {
      return Left(parseFailure(e));
    }
    // } else {
    //   return Left(NetworkFailure());
    // }
  }
}
