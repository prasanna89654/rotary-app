import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:rotary/core/use_cases.dart/use_cases.dart';
import 'package:rotary/data/models/news/news_details_model.dart';
import 'package:rotary/data/models/news/news_response_model.dart';
import 'package:rotary/domain/usecases/news_usecase/get_news_details_usecase.dart';
import 'package:rotary/domain/usecases/news_usecase/get_news_usecase.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  GetNewsUseCase getNewsUseCase;
  GetNewsDetailsUseCase getNewsDetailsUseCase;
  NewsBloc(this.getNewsUseCase, this.getNewsDetailsUseCase)
      : super(NewsInitial()) {
    on<NewsEvent>((event, emit) {});
    on<LoadNewsEvent>((event, emit) async {
      emit(NewsLoading());
      emit(await _mapLoadNewsEventToState(
          await getNewsUseCase.call(NoParams())));
    });
    on<LoadNewsDetailsEvent>((event, emit) async {
      emit(NewsLoading());
      emit(await _mapLoadNewsDetailsEventToState(
          await getNewsDetailsUseCase.call(event.id)));
    });
  }
  Future<NewsState> _mapLoadNewsEventToState(
      Either<Failure, NewsResponseModel> either) async {
    return either.fold(
        (l) => NewsError(l.failureMessage), (r) => NewsLoaded(news: r));
  }

  Future<NewsState> _mapLoadNewsDetailsEventToState(
      Either<Failure, NewsDetailsModel> either) async {
    return either.fold((l) => NewsError(l.failureMessage), (r) {
      print(r.toString());
      return NewsDetailsLoaded(newsdetails: r);
    });
  }
}
