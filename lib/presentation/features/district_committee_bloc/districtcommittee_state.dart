part of 'districtcommittee_bloc.dart';

abstract class DistrictcommitteeState extends Equatable {
  const DistrictcommitteeState();

  @override
  List<Object> get props => [];
}

class DistrictcommitteeInitial extends DistrictcommitteeState {}

class DistrictcommitteeLoadingState extends DistrictcommitteeState {}

class DistrictcommitteeLoadedState extends DistrictcommitteeState {
  final DistrictComitteeResponseModel districtCommitteeList;

  DistrictcommitteeLoadedState(this.districtCommitteeList);
}

class DistrictComitteeSearchLoaded extends DistrictcommitteeState {
  final DistrictComitteeResponseModel districtCommitteeList;

  DistrictComitteeSearchLoaded(this.districtCommitteeList);
}

class DistrictcommitteeErrorState extends DistrictcommitteeState {
  final String error;

  DistrictcommitteeErrorState(this.error);
}
