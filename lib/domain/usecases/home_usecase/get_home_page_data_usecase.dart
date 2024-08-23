import 'package:dartz/dartz.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:rotary/core/use_cases.dart/use_cases.dart';
import 'package:rotary/data/models/home/home_model.dart';
import 'package:rotary/domain/repository/home_repository/home_repository.dart';

abstract class GetHomePageUSeCase
    implements UseCases<Either<Failure, HomeModel>, NoParams> {}

class GetHomePageUseCaseImpl implements GetHomePageUSeCase {
  HomeRepository homeRepository;
  GetHomePageUseCaseImpl({required this.homeRepository});
  @override
  Future<Either<Failure, HomeModel>> call(NoParams params) async {
    return homeRepository.getHomePageData();
  }
}
