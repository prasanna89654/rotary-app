import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:rotary/core/use_cases.dart/use_cases.dart';
import 'package:rotary/data/models/district_committee/district_committee_model.dart';
import 'package:rotary/domain/usecases/district_committee_usecase/district_committee_usecase.dart';

import '../../../data/models/district_committee/district_committee_response_model.dart';

part 'districtcommittee_event.dart';
part 'districtcommittee_state.dart';

class DistrictcommitteeBloc
    extends Bloc<DistrictcommitteeEvent, DistrictcommitteeState> {
  GetDistrictCommitteeUseCase getDistrictCommitteeUseCase;
  DistrictcommitteeBloc(this.getDistrictCommitteeUseCase)
      : super(DistrictcommitteeInitial()) {
    on<DistrictcommitteeEvent>((event, emit) {});
    on<GetAllDistrictCommitteesEvent>((event, emit) async {
      emit(DistrictcommitteeLoadingState());
      emit(await _mapEventGetAllDistrictCommitteesToState(
          await getDistrictCommitteeUseCase.call(NoParams())));
    });
    on<SearchCommitteeEvent>((event, emit) async {
      emit(DistrictcommitteeLoadingState());
      emit(await _mapEventSearchCommitteeToState(event.searchText));
    });
    on<SortCommitteeEvent>((event, emit) async {
      emit(DistrictcommitteeLoadingState());
      emit(await _mapEventSortCommitteeToState(event.ascOrDesc));
    });
  }

  DistrictComitteeResponseModel? districtCommittees;

  Future<DistrictcommitteeState> _mapEventGetAllDistrictCommitteesToState(
      Either<Failure, DistrictComitteeResponseModel> either) async {
    return either.fold((l) => DistrictcommitteeErrorState(l.failureMessage),
        (r) {
      districtCommittees = r;
      return DistrictcommitteeLoadedState(districtCommittees!);
    });
  }

  Future<DistrictcommitteeState> _mapEventSearchCommitteeToState(
      String searchText) async {
    DistrictComitteeResponseModel filteredDistrictCommittees =
        DistrictComitteeResponseModel(
            councils: [], main: DistrictCommitteeModel());

    if (districtCommittees != null) {
      districtCommittees!.councils!.forEach((council) {
        if (council.councilName!
            .toLowerCase()
            .contains(searchText.toLowerCase())) {
          filteredDistrictCommittees.councils?.add(council);
        }
      });
    }
    if (filteredDistrictCommittees.councils!.isNotEmpty) {
      filteredDistrictCommittees.main = districtCommittees?.main;
      // log("From bloc council: ${filteredDistrictCommittees.councils}");
      // log("From bloc main: ${filteredDistrictCommittees.main}");
      // print(filteredDistrictCommittees.main);
      return DistrictComitteeSearchLoaded(filteredDistrictCommittees);
    } else {
      return DistrictcommitteeErrorState("No District Committee Found");
    }
  }

  Future<DistrictcommitteeState> _mapEventSortCommitteeToState(
      String ascOrDesc) async {
    // List<DistrictCommitteeModel> sortedDistrictCommittees = [];
    if (districtCommittees != null) {
      districtCommittees!.councils!.sort((a, b) {
        if (a.name != null && b.name != null) {
          if (ascOrDesc == "asc") {
            return a.councilName!
                .toLowerCase()
                .compareTo(b.name!.toLowerCase());
          } else {
            return b.councilName!
                .toLowerCase()
                .compareTo(a.name!.toLowerCase());
          }
        } else {
          return 0;
        }

        // DistrictcommitteeLoadedState(districtCommittees ?? []);
      });

      // if (ascOrDesc == "asc") {
      //   sortedDistrictCommittees = districtCommittees!.toList()
      //     ..sort((a, b) => a.name!.compareTo(b.name!));
      // } else {
      //   sortedDistrictCommittees = districtCommittees!.toList()
      //     ..sort((a, b) => b.name!.compareTo(a.name!));
      // }
    }
    if (districtCommittees == null) {
      return DistrictcommitteeErrorState("No District Committee Found");
    } else {
      return DistrictcommitteeLoadedState(districtCommittees!);
    }
  }
}
