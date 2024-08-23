part of 'homepage_bloc.dart';

abstract class HomepageState extends Equatable {
  const HomepageState();

  @override
  List<Object> get props => [];
}

class HomepageInitial extends HomepageState {}

class HomepageLoading extends HomepageState {}

class HomepageLoaded extends HomepageState {
  final HomeModel homeModel;
  final NewsResponseModel newsModel;
  final EventResponseModel upcommingEventModel;

  HomepageLoaded(
      {required this.newsModel,
      required this.homeModel,
      required this.upcommingEventModel});

  @override
  List<Object> get props => [homeModel];
}

class HomepageError extends HomepageState {
  final String message;

  HomepageError({required this.message});

  @override
  List<Object> get props => [message];
}
