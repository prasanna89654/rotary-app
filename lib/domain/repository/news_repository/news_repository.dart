import 'package:dartz/dartz.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:rotary/data/models/news/news_details_model.dart';
import 'package:rotary/data/models/news/news_response_model.dart';

abstract class NewsRepository {
  Future<Either<Failure, NewsResponseModel>> getNews();
  Future<Either<Failure, NewsDetailsModel>> getNewsDetails(String id);
}
