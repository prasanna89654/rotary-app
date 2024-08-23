import 'package:dartz/dartz.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:rotary/core/use_cases.dart/use_cases.dart';
import 'package:rotary/data/models/news/news_response_model.dart';
import 'package:rotary/domain/repository/news_repository/news_repository.dart';

abstract class GetNewsUseCase
    implements UseCases<Either<Failure, NewsResponseModel>, NoParams> {}

class GetNewsUseCaseImpl implements GetNewsUseCase {
  final NewsRepository newsRepository;

  GetNewsUseCaseImpl({required this.newsRepository});
  @override
  Future<Either<Failure, NewsResponseModel>> call(NoParams params) {
    return newsRepository.getNews();
  }
}
