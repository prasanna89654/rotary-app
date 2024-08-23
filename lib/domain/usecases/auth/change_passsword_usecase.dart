import 'package:dartz/dartz.dart';
import 'package:rotary/core/use_cases.dart/use_cases.dart';
import 'package:rotary/domain/repository/user_repository.dart';

import '../../../core/error/failure.dart';

abstract class ChangePasswordUsecase
    implements UseCases<Either<Failure, String>, ChangePasswordParams> {}

class ChangePasswordUseCaseImpl implements ChangePasswordUsecase {
  UserRepository userRepository;
  ChangePasswordUseCaseImpl({required this.userRepository});
  @override
  Future<Either<Failure, String>> call(ChangePasswordParams params) async {
    return await userRepository.changePassword(
        params.currentPassword, params.newPassword);
  }
}

class ChangePasswordParams {
  String currentPassword;
  String newPassword;
  ChangePasswordParams(this.currentPassword, this.newPassword);
}
