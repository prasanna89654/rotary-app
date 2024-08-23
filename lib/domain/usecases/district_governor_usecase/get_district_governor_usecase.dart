import 'package:dartz/dartz.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:rotary/core/use_cases.dart/use_cases.dart';
import 'package:rotary/data/models/district_governors/district_governor_response_model.dart';
import 'package:rotary/domain/repository/district_governors_repository/district_governors_repository.dart';

abstract class GetDistrictGovernorsUseCase
    implements
        UseCases<Either<Failure, DistrictGovernorResponseModel>, NoParams> {}

class GetDistrictGovernorsUseCaseImpl implements GetDistrictGovernorsUseCase {
  DistrictGovernorRepository districtGovernorRepository;
  GetDistrictGovernorsUseCaseImpl({required this.districtGovernorRepository});
  @override
  Future<Either<Failure, DistrictGovernorResponseModel>> call(NoParams params) {
    return districtGovernorRepository.getAllDistrictGovernors();
  }
}
