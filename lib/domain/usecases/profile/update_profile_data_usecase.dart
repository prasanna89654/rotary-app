import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../core/use_cases.dart/use_cases.dart';
import '../../../data/models/profile/update_profile_request_model.dart';
import '../../repository/profile_repository.dart';

abstract class UpdateProfileDataUsecase
    implements UseCases<Either<Failure, bool>, UpdateProfileRequestModel> {}

class UpdateProfileDataUsecaseImpl implements UpdateProfileDataUsecase {
  ProfileRepository profileRepository;
  UpdateProfileDataUsecaseImpl({required this.profileRepository});

  @override
  Future<Either<Failure, bool>> call(UpdateProfileRequestModel params) async {
    return await profileRepository.updateProfile(params);
  }
}
