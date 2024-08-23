part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {
  final bool isAuthenticated;
  AuthInitial(this.isAuthenticated);

  @override
  List<Object> get props => [isAuthenticated];
}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final bool isAuthenticated;

  AuthSuccess(this.isAuthenticated);
}
