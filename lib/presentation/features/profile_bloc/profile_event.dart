part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetProfileData extends ProfileEvent {}

class UpdateProfileData extends ProfileEvent {
  final UpdateProfileRequestModel updateProfileRequestModel;

  UpdateProfileData(this.updateProfileRequestModel);

  @override
  List<Object> get props => [updateProfileRequestModel];
}
