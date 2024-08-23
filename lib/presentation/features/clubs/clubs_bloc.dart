import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:rotary/core/use_cases.dart/use_cases.dart';
import 'package:rotary/data/models/club/club_details_model/club_details_response_model.dart';
import 'package:rotary/data/models/club/club_details_model/club_details_request_model.dart';
import 'package:rotary/domain/entities/club/club.dart';
import 'package:rotary/domain/usecases/club_usecase/get_club_details.dart';
import 'package:rotary/domain/usecases/club_usecase/get_clubs.dart';

part 'clubs_event.dart';
part 'clubs_state.dart';

class ClubsBloc extends Bloc<ClubsEvent, ClubsState> {
  GetClubsUseCase getClubsUseCase;
  GetClubDetailsUseCase getClubDetailsUseCase;
  ClubsBloc(
      {required this.getClubsUseCase, required this.getClubDetailsUseCase})
      : super(ClubsInitial());

  @override
  Stream<ClubsState> mapEventToState(ClubsEvent event) async* {
    if (event is GetAllClubsEvent) {
      yield ClubsLoadingState();
      yield* _mapGetAllClubsToState(await getClubsUseCase.call(NoParams()));
    }
    if (event is GetClubDetailsEvent) {
      yield ClubsLoadingState();
      yield* _mapGetClubDetailsToState(
          await getClubDetailsUseCase.call(event.clubDetailsRequestModel));
    }
    if (event is SearchClubEvent) {
      // yield ClubsLoadingState();
      yield* _mapSearchClubToState(event.searchText);
    }
    if (event is SortClubEvent) {
      yield ClubsLoadingState();
      yield* _mapApplyFilterToClubToState(event.ascOrDesc);
    }
  }

  Clubs? clubs;

  Stream<ClubsState> _mapGetClubDetailsToState(
      Either<Failure, ClubDetailsResponseModel> clubDetail) async* {
    // print(Right(clubDetail));
    yield clubDetail.fold(
      (failure) => ClubsErrorState(failure.failureMessage),
      (clubDetails) {
        log(clubDetails.members.toString());
        return ClubDetailsLoadedState(clubDetails: clubDetails);
      },
    );
  }

  Stream<ClubsState> _mapGetAllClubsToState(
      Either<Failure, Clubs> either) async* {
    yield either.fold(
      (l) => ClubsErrorState(l.failureMessage),
      (r) {
        clubs = r;
        return ClubsLoadedState(clubs: clubs!);
      },
    );
  }

  Stream<ClubsState> _mapSearchClubToState(String searchText) async* {
    yield ClubsLoadingState();
    Clubs clubsHere = Clubs(clubs: []);
    if (clubs != null) {
      clubs!.clubs.forEach((club) {
        if (club.club.toLowerCase().contains(searchText.toLowerCase())) {
          clubsHere.clubs.add(club);
        }
      });
    }
    if (clubsHere.clubs.isEmpty) {
      yield ClubsErrorState("No clubs found");
    } else {
      yield ClubsLoadedState(clubs: clubsHere);
    }
    // yield ClubsLoadingState();
    // yield ClubsLoadedState(clubs: clubs!);
  }

  Stream<ClubsState> _mapApplyFilterToClubToState(String ascOrDesc) async* {
    yield ClubsLoadingState();
    // Clubs clubsHere = Clubs(clubs: []);
    if (clubs != null) {
      clubs!.clubs.sort((a, b) {
        if (ascOrDesc == "asc") {
          return a.club.toLowerCase().compareTo(b.club.toLowerCase());
        } else {
          return b.club.toLowerCase().compareTo(a.club.toLowerCase());
        }
      });
    }
    yield ClubsLoadedState(clubs: clubs!);
  }
}
