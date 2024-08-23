part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class LoadNewsEvent extends NewsEvent {}

class LoadNewsDetailsEvent extends NewsEvent {
  final String id;

  LoadNewsDetailsEvent(this.id);
}
