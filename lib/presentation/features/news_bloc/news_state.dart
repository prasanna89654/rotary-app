part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final NewsResponseModel news;

  NewsLoaded({required this.news});
}

class NewsDetailsLoaded extends NewsState {
  final NewsDetailsModel newsdetails;

  NewsDetailsLoaded({required this.newsdetails});
}

class NewsError extends NewsState {
  final String message;

  NewsError(this.message);
}
