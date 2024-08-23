import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rotary/core/use_cases.dart/use_cases.dart';
import 'package:rotary/data/models/profile/profile_model.dart';
import 'package:rotary/data/models/profile/update_profile_request_model.dart';
import 'package:rotary/domain/usecases/profile/get_profile_data_usecase.dart';
import 'package:rotary/domain/usecases/profile/update_profile_data_usecase.dart';

import '../../../core/error/failure.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  GetProfileDataUsecase getProfileDataUsecase;
  UpdateProfileDataUsecase updateProfileDataUsecase;
  ProfileBloc(this.getProfileDataUsecase, this.updateProfileDataUsecase)
      : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) async {
      if (event is GetProfileData) {
        emit(ProfileLoading());
        emit(
          await _getProfileData(
            await getProfileDataUsecase.call(NoParams()),
          ),
        );
      } else if (event is UpdateProfileData) {
        emit(ProfileLoading());
        emit(
          await _updateProfileData(
            await updateProfileDataUsecase
                .call(event.updateProfileRequestModel),
          ),
        );
      }
    });
  }
  Future<ProfileState> _getProfileData(
      Either<Failure, ProfileModel> either) async {
    return await either.fold(
      (l) => ProfileError(l.failureMessage),
      (r) => ProfileLoaded(r),
    );
  }

  Future<ProfileState> _updateProfileData(Either<Failure, bool> either) async {
    return await either.fold(
      (l) => ProfileError(l.failureMessage),
      (r) => ProfileUpdated(),
    );
  }
}
