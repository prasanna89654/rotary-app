part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends SignInEvent {
  final String username;
  final String password;

  const LoginEvent({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

class LogOutEvent extends SignInEvent {}

class ChangePasswordEvent extends SignInEvent {
  final String currentPassword;
  final String newPassword;
  ChangePasswordEvent(
      {required this.currentPassword, required this.newPassword});
}

class ForgotPasswordEvent extends SignInEvent {
  final String email;
  ForgotPasswordEvent(this.email);
}
