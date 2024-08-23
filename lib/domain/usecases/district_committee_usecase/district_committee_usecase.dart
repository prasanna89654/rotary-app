import 'package:dartz/dartz.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:rotary/core/use_cases.dart/use_cases.dart';
import 'package:rotary/domain/repository/district_committee_repository/district_committee_repository.dart';

import '../../../data/models/district_committee/district_committee_response_model.dart';

abstract class GetDistrictCommitteeUseCase
    implements
        UseCases<Either<Failure, DistrictComitteeResponseModel>, NoParams> {}

class GetDistrictCommitteeUseCaseImpl implements GetDistrictCommitteeUseCase {
  DistrictCommitteeRepository districtCommitteeRepository;
  GetDistrictCommitteeUseCaseImpl({required this.districtCommitteeRepository});
  @override
  Future<Either<Failure, DistrictComitteeResponseModel>> call(NoParams params) {
    return districtCommitteeRepository.getDistrictCommittee();
  }
}
