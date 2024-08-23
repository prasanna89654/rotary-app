import 'package:dartz/dartz.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:rotary/core/use_cases.dart/use_cases.dart';
import 'package:rotary/data/models/profile/profile_model.dart';
import 'package:rotary/domain/repository/profile_repository.dart';

abstract class GetProfileDataUsecase
    implements UseCases<Either<Failure, ProfileModel>, NoParams> {}

class GetProfileDataUsecaseImpl implements GetProfileDataUsecase {
  ProfileRepository profileRepository;
  GetProfileDataUsecaseImpl({required this.profileRepository});
  @override
  Future<Either<Failure, ProfileModel>> call(NoParams noParams) async {
    return await profileRepository.getProfile();
  }
}
