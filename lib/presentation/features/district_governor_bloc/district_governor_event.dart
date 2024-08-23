part of 'district_governor_bloc.dart';

abstract class DistrictGovernorEvent extends Equatable {
  const DistrictGovernorEvent();

  @override
  List<Object> get props => [];
}

class GetAllDistrictGovernors extends DistrictGovernorEvent {}

class GetDistrictGovernorDetail extends DistrictGovernorEvent {
  final String id;

  GetDistrictGovernorDetail(this.id);

  @override
  List<Object> get props => [id];
}
