import 'package:dartz/dartz.dart';
import 'package:rotary/data/models/login/login_response.dart';

import '../../core/error/failure.dart';

abstract class UserRepository {
  Future<Either<Failure, LoginResponse>> login(String email, String password);
  Future<void> logOut();
  Future<Either<Failure, String>> changePassword(
      String currentPassword, String newPassword);
  Future<Either<Failure, bool>> forgotPassword(String email);
  // Future<void> signUp(String email, String password);
  // Future<void> updatePassword(String password);
  // Future<void> updateEmail(String email);
  // Future<void> updateUserName(String userName);
}
