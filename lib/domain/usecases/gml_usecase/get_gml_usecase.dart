import 'package:dartz/dartz.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:rotary/core/use_cases.dart/use_cases.dart';
import 'package:rotary/data/models/gml/gml_model.dart';
import 'package:rotary/domain/repository/gml_repository/gml_repository.dart';

abstract class GetGmlUsecase
    implements UseCases<Either<Failure, List<GmlModel>>, NoParams> {}

class GetGmlUsecaseImpl implements GetGmlUsecase {
  GmlRepository gmlRepository;
  GetGmlUsecaseImpl({required this.gmlRepository});
  @override
  Future<Either<Failure, List<GmlModel>>> call(NoParams params) async {
    return gmlRepository.getGml();
  }
}
