import 'package:dartz/dartz.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:rotary/core/use_cases.dart/use_cases.dart';
import 'package:rotary/data/models/resources/resource_description_model.dart';

import '../../repository/resources_repository/resources_repository.dart';

abstract class GetResourceDescriptionUseCase
    extends UseCases<Either<Failure, ResourceDescriptionModel>, String> {}

class GetResourceDescriptionUseCaseImpl
    implements GetResourceDescriptionUseCase {
  ResourcesRepository resourcesRepository;
  GetResourceDescriptionUseCaseImpl(this.resourcesRepository);
  @override
  Future<Either<Failure, ResourceDescriptionModel>> call(String id) async {
    return await resourcesRepository.getResourceDescription(id);
  }
}
