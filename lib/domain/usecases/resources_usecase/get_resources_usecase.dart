import 'package:dartz/dartz.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:rotary/core/use_cases.dart/use_cases.dart';
import 'package:rotary/data/models/resources/resources_model.dart';
import 'package:rotary/domain/repository/resources_repository/resources_repository.dart';

abstract class GetResourcesUseCase
    implements UseCases<Either<Failure, List<ResourcesModel>>, NoParams> {}

class GetResourcesUseCaseImpl implements GetResourcesUseCase {
  ResourcesRepository resourcesRepository;
  GetResourcesUseCaseImpl({required this.resourcesRepository});
  @override
  Future<Either<Failure, List<ResourcesModel>>> call(NoParams params) {
    return resourcesRepository.getResources();
  }
}
