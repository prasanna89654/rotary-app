import 'package:dartz/dartz.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:rotary/core/use_cases.dart/use_cases.dart';
import 'package:rotary/domain/repository/user_repository.dart';

abstract class ForgetPasswordUsecase
    implements UseCases<Either<Failure, bool>, String> {}

class ForgetPasswordUsecaseImpl implements ForgetPasswordUsecase {
  UserRepository userRepository;
  ForgetPasswordUsecaseImpl({required this.userRepository});
  @override
  Future<Either<Failure, bool>> call(String email) async {
    return await userRepository.forgotPassword(email);
  }
}
