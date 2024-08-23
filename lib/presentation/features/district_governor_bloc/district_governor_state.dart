part of 'district_governor_bloc.dart';

abstract class DistrictGovernorState extends Equatable {
  const DistrictGovernorState();

  @override
  List<Object> get props => [];
}

class DistrictGovernorInitial extends DistrictGovernorState {}

class DistrictGovernorLoading extends DistrictGovernorState {}

class DistrictGovernorLoaded extends DistrictGovernorState {
  final DistrictGovernorResponseModel? districtGovernorResponseModel;
  final DistrictGovernorDetailModel? districtGovernorDetailModel;

  DistrictGovernorLoaded(
      {this.districtGovernorResponseModel, this.districtGovernorDetailModel});

  @override
  List<Object> get props =>
      [districtGovernorResponseModel ?? "", districtGovernorDetailModel ?? ""];
}

class DistrictGovernorError extends DistrictGovernorState {
  final String error;

  DistrictGovernorError(this.error);
}
