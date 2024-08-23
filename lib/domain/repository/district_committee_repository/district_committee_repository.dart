import 'package:dartz/dartz.dart';
import 'package:rotary/core/error/failure.dart';

import '../../../data/models/district_committee/district_committee_response_model.dart';

abstract class DistrictCommitteeRepository {
  Future<Either<Failure, DistrictComitteeResponseModel>> getDistrictCommittee();
}
