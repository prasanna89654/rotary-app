part of 'clubs_bloc.dart';

abstract class ClubsEvent extends Equatable {
  const ClubsEvent();

  @override
  List<Object> get props => [];
}

class GetAllClubsEvent extends ClubsEvent {}

class GetClubDetailsEvent extends ClubsEvent {
  final ClubDetailsRequestModel clubDetailsRequestModel;

  GetClubDetailsEvent({required this.clubDetailsRequestModel});

  @override
  List<Object> get props => [clubDetailsRequestModel];
}

class SearchClubEvent extends ClubsEvent {
  final String searchText;

  SearchClubEvent({required this.searchText});

  @override
  List<Object> get props => [searchText];
}

class SortClubEvent extends ClubsEvent {
  final String ascOrDesc;

  SortClubEvent({required this.ascOrDesc});

  @override
  List<Object> get props => [ascOrDesc];
}
