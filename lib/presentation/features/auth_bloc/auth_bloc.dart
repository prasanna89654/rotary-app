import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rotary/data/data_sources/user/user_local_data_sources.dart';
import 'package:rotary/domain/usecases/auth/authenticate_user_usecase.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserLocalDataSources userLocalDataSources;
  AuthenticateUsecase authenticateUsecase;
  AuthBloc(this.authenticateUsecase, this.userLocalDataSources)
      : super(AuthInitial(false)) {
    on<AuthEvent>((event, emit) async {
      if (event is CheckAuthenticationEvent) {
        emit(AuthLoading());
        isAuthenticated = await userLocalDataSources.isLoggedIn();
        emit(AuthSuccess(isAuthenticated));
      }
    });
  }
  late bool isAuthenticated;
}
