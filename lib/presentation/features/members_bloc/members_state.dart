part of 'members_bloc.dart';

abstract class MembersState extends Equatable {
  const MembersState();

  @override
  List<Object> get props => [];
}

class MembersInitial extends MembersState {}

class MembersLoadingState extends MembersState {}

class MembersLoadingNextDataState extends MembersState {}

class MembersLoadedState extends MembersState {
  final MemberResponseModel memberResponseModel;

  MembersLoadedState(this.memberResponseModel);
}

class MembersErrorState extends MembersState {
  final String error;

  MembersErrorState(this.error);
}
