part of 'members_bloc.dart';

abstract class MembersEvent extends Equatable {
  const MembersEvent();

  @override
  List<Object> get props => [];
}

class GetAllMembersEvent extends MembersEvent {}

class LoadNextPageMembersEvent extends MembersEvent {
  final MemberPaginationRequestModel memberPaginationRequestModel;
  LoadNextPageMembersEvent(this.memberPaginationRequestModel);
}

class SearchMembersEvent extends MembersEvent {
  final SearchMemberRequestModel searchMemberRequestModel;
  SearchMembersEvent(this.searchMemberRequestModel);
}
