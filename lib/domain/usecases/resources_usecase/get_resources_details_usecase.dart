import 'package:dartz/dartz.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:rotary/core/use_cases.dart/use_cases.dart';
import 'package:rotary/data/models/resources/resource_details/resources_detail_response_model.dart';
import 'package:rotary/domain/repository/resources_repository/resources_repository.dart';

abstract class GetResourcesDetailsUseCase
    implements
        UseCases<Either<Failure, ResourcesDetailResponseModel>, String> {}

class GetResourcesDetailsUseCaseImpl implements GetResourcesDetailsUseCase {
  ResourcesRepository resourcesRepository;
  GetResourcesDetailsUseCaseImpl({required this.resourcesRepository});
  @override
  Future<Either<Failure, ResourcesDetailResponseModel>> call(String id) {
    return resourcesRepository.getResourceDetails(id);
  }
}
