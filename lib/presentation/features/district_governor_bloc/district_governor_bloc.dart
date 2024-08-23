import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:rotary/core/use_cases.dart/use_cases.dart';
import 'package:rotary/data/models/district_governors/district_governor_response_model.dart';
import 'package:rotary/domain/usecases/district_governor_usecase/get_district_governor_details.dart';
import 'package:rotary/domain/usecases/district_governor_usecase/get_district_governor_usecase.dart';

import '../../../data/models/district_governors/district_governor_detail_model/district_governor_detail_model..dart';

part 'district_governor_event.dart';
part 'district_governor_state.dart';

class DistrictGovernorBloc
    extends Bloc<DistrictGovernorEvent, DistrictGovernorState> {
  GetDistrictGovernorsUseCase getDistrictGovernorUseCase;
  GetDistrictGovernorDetailsUseCase getDistrictGovernorDetailUseCase;
  DistrictGovernorBloc(
      this.getDistrictGovernorUseCase, this.getDistrictGovernorDetailUseCase)
      : super(DistrictGovernorInitial()) {
    on<DistrictGovernorEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetAllDistrictGovernors>(((event, emit) async {
      emit(DistrictGovernorLoading());
      emit(await _mapEventGetAllDistrictGovernorsToState(
          await getDistrictGovernorUseCase.call(NoParams())));
    }));
    on<GetDistrictGovernorDetail>(((event, emit) async {
      emit(DistrictGovernorLoading());
      emit(await _mapEventGetDistrictGovernorDetailToState(
          await getDistrictGovernorDetailUseCase.call(event.id)));
    }));
  }

  Future<DistrictGovernorState> _mapEventGetAllDistrictGovernorsToState(
      Either<Failure, DistrictGovernorResponseModel> either) async {
    return either.fold(
        (l) => DistrictGovernorError(l.failureMessage),
        (r) => DistrictGovernorLoaded(
            districtGovernorResponseModel: r,
            districtGovernorDetailModel: null));
  }

  Future<DistrictGovernorState> _mapEventGetDistrictGovernorDetailToState(
      Either<Failure, DistrictGovernorDetailModel> either) async {
    return either.fold(
        (l) => DistrictGovernorError(l.failureMessage),
        (r) => DistrictGovernorLoaded(
            districtGovernorResponseModel: null,
            districtGovernorDetailModel: r));
  }
}
