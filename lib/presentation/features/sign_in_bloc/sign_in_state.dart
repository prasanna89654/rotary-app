part of 'sign_in_bloc.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class SignInLoaded extends SignInState {
  final LoginResponse loginResponse;
  SignInLoaded(this.loginResponse);
}

class SignInError extends SignInState {
  final String error;
  SignInError(this.error);
  @override
  List<Object> get props => [error];
}

class SignInLoggedOut extends SignInState {}

class SignInSuccess extends SignInState {}

class ChangePasswordSuccess extends SignInState {
  final String message;
  ChangePasswordSuccess(this.message);
}
