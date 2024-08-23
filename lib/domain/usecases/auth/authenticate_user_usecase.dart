import 'package:dartz/dartz.dart';
import 'package:rotary/core/use_cases.dart/use_cases.dart';
import 'package:rotary/data/models/login/login_response.dart';
import 'package:rotary/domain/repository/user_repository.dart';

import '../../../core/error/failure.dart';

abstract class AuthenticateUsecase
    implements UseCases<Either<Failure, LoginResponse>, AuthenticateParams> {}

class AuthenticateUsecaseImpl implements AuthenticateUsecase {
  final UserRepository userRepository;

  AuthenticateUsecaseImpl({required this.userRepository});

  @override
  Future<Either<Failure, LoginResponse>> call(AuthenticateParams params) async {
    return await userRepository.login(params.username, params.password);
  }
}

class AuthenticateParams {
  final String username;
  final String password;

  AuthenticateParams({required this.username, required this.password});
}
