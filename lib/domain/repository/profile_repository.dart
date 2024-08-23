import 'package:dartz/dartz.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:rotary/data/models/profile/profile_model.dart';

import '../../data/models/profile/update_profile_request_model.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileModel>> getProfile();
  Future<Either<Failure, bool>> updateProfile(
      UpdateProfileRequestModel userData);
}
