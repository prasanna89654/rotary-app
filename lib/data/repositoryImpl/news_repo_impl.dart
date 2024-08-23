import 'package:rotary/core/network/network_info.dart';
import 'package:rotary/data/data_sources/news/news_remote_data_sources.dart';
import 'package:rotary/data/models/news/news_details_model.dart';
import 'package:rotary/data/models/news/news_response_model.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:rotary/domain/repository/news_repository/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NetworkInfo networkInfo;
  final NewsRemoteDataSource remoteDataSource;
  NewsRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });
  @override
  Future<Either<Failure, NewsResponseModel>> getNews() async {
    // if (await networkInfo.isConnected) {
    try {
      final result = await remoteDataSource.getNews();
      return Right(result);
    } catch (e) {
      return Left(parseFailure(e));
    }
    // } else {
    //   return Left(NetworkFailure());
    // }
  }

  @override
  Future<Either<Failure, NewsDetailsModel>> getNewsDetails(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getNewsDetails(id);
        return Right(result);
      } catch (e) {
        return Left(ServerFailure(failureMessage: e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
