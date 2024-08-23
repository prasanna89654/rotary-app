import 'package:dartz/dartz.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:rotary/data/models/home/home_model.dart';

abstract class HomeRepository {
  Future<Either<Failure, HomeModel>> getHomePageData();
}
