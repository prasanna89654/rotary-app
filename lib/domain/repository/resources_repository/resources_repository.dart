import 'package:dartz/dartz.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:rotary/data/models/resources/resource_description_model.dart';
import 'package:rotary/data/models/resources/resource_details/resources_detail_response_model.dart';
import 'package:rotary/data/models/resources/resources_model.dart';

abstract class ResourcesRepository {
  Future<Either<Failure, List<ResourcesModel>>> getResources();
  Future<Either<Failure, ResourcesDetailResponseModel>> getResourceDetails(
      String id);
  Future<Either<Failure, ResourceDescriptionModel>> getResourceDescription(
      String id);
}
