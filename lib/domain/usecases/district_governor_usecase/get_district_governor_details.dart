import 'package:dartz/dartz.dart';
import 'package:rotary/core/use_cases.dart/use_cases.dart';
import 'package:rotary/domain/repository/district_governors_repository/district_governors_repository.dart';

import '../../../core/error/failure.dart';
import '../../../data/models/district_governors/district_governor_detail_model/district_governor_detail_model..dart';

abstract class GetDistrictGovernorDetailsUseCase
    implements UseCases<Either<Failure, DistrictGovernorDetailModel>, String> {}

class GetDistrictGovernorDetailsUseCaseImpl
    implements GetDistrictGovernorDetailsUseCase {
  DistrictGovernorRepository districtGovernorRepository;
  GetDistrictGovernorDetailsUseCaseImpl(
      {required this.districtGovernorRepository});
  @override
  Future<Either<Failure, DistrictGovernorDetailModel>> call(String id) {
    return districtGovernorRepository.getDistrictGovernorDetail(id);
  }
}
