import 'package:dartz/dartz.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:rotary/data/models/gml/gml_model.dart';

abstract class GmlRepository {
  Future<Either<Failure, List<GmlModel>>> getGml();
}
