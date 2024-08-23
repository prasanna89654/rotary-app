import 'package:dartz/dartz.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:rotary/data/models/district_governors/district_governor_response_model.dart';

import '../../../data/models/district_governors/district_governor_detail_model/district_governor_detail_model..dart';

abstract class DistrictGovernorRepository {
  Future<Either<Failure, DistrictGovernorResponseModel>>
      getAllDistrictGovernors();
  Future<Either<Failure, DistrictGovernorDetailModel>>
      getDistrictGovernorDetail(String id);
}
