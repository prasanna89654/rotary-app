part of 'districtcommittee_bloc.dart';

abstract class DistrictcommitteeEvent extends Equatable {
  const DistrictcommitteeEvent();

  @override
  List<Object> get props => [];
}

class GetAllDistrictCommitteesEvent extends DistrictcommitteeEvent {}

class SearchCommitteeEvent extends DistrictcommitteeEvent {
  final String searchText;

  SearchCommitteeEvent({required this.searchText});

  @override
  List<Object> get props => [searchText];
}

class SortCommitteeEvent extends DistrictcommitteeEvent {
  final String ascOrDesc;

  SortCommitteeEvent({required this.ascOrDesc});

  @override
  List<Object> get props => [ascOrDesc];
}
