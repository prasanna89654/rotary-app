import 'package:dartz/dartz.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:rotary/core/use_cases.dart/use_cases.dart';
import 'package:rotary/data/models/news/news_details_model.dart';
import 'package:rotary/domain/repository/news_repository/news_repository.dart';

abstract class GetNewsDetailsUseCase
    implements UseCases<Either<Failure, NewsDetailsModel>, String> {}

class GetNewsDetailsUseCaseImpl implements GetNewsDetailsUseCase {
  NewsRepository newsRepository;
  GetNewsDetailsUseCaseImpl({required this.newsRepository});
  @override
  Future<Either<Failure, NewsDetailsModel>> call(String id) {
    return newsRepository.getNewsDetails(id);
  }
}
