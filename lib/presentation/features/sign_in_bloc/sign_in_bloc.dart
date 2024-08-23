import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rotary/data/models/login/login_response.dart';
import 'package:rotary/domain/repository/user_repository.dart';
import 'package:rotary/domain/usecases/auth/change_passsword_usecase.dart';
import 'package:rotary/domain/usecases/auth/forget_password_usecase.dart';

import '../../../core/error/failure.dart';
import '../../../domain/usecases/auth/authenticate_user_usecase.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  // UserLocalDataSources userLocalDataSources;
  UserRepository userRepository;
  AuthenticateUsecase authenticateUsecase;
  ChangePasswordUsecase changePasswordUsecase;
  ForgetPasswordUsecase forgetPasswordUsecase;

  SignInBloc(this.authenticateUsecase, this.userRepository,
      this.changePasswordUsecase, this.forgetPasswordUsecase)
      : super(SignInInitial()) {
    on<SignInEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(SignInLoading());
        emit(
          await _login(
            await authenticateUsecase.call(
              AuthenticateParams(
                username: event.username,
                password: event.password,
              ),
            ),
          ),
        );
      } else if (event is LogOutEvent) {
        emit(SignInLoading());
        emit(await _logout());
      } else if (event is ChangePasswordEvent) {
        emit(SignInLoading());
        emit(await _changePassword(await changePasswordUsecase.call(
          ChangePasswordParams(
            event.currentPassword,
            event.newPassword,
          ),
        )));
      } else if (event is ForgotPasswordEvent) {
        emit(SignInLoading());
        emit(await _forgotPassword(
            await forgetPasswordUsecase.call(event.email)));
      }
    });
  }

  Future<SignInState> _login(Either<Failure, LoginResponse> either) async {
    return await either.fold(
      (l) => SignInError(l.failureMessage),
      (r) {
        return SignInLoaded(r);
      },
    );
  }

  Future<SignInState> _logout() async {
    try {
      await userRepository.logOut();
      return SignInLoggedOut();
    } catch (e) {
      return SignInLoggedOut();
    }
  }

  Future<SignInState> _changePassword(Either<Failure, String> either) async {
    return await either.fold(
      (l) => SignInError(l.toString()),
      (r) {
        return ChangePasswordSuccess(r);
      },
    );
  }

  Future<SignInState> _forgotPassword(Either<Failure, bool> either) async {
    return await either.fold(
      (l) => SignInError(l.failureMessage),
      (r) {
        return SignInSuccess();
      },
    );
  }
}
