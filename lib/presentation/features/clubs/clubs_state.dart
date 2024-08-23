part of 'clubs_bloc.dart';

abstract class ClubsState extends Equatable {
  const ClubsState();

  @override
  List<Object> get props => [];
}

class ClubsInitial extends ClubsState {}

class ClubsLoadingState extends ClubsState {}

class ClubsLoadedState extends ClubsState {
  final Clubs clubs;

  ClubsLoadedState({required this.clubs});
}

class ClubDetailsLoadedState extends ClubsState {
  final ClubDetailsResponseModel clubDetails;

  ClubDetailsLoadedState({required this.clubDetails});
}

class ClubsErrorState extends ClubsState {
  final String message;

  ClubsErrorState(this.message);
}
