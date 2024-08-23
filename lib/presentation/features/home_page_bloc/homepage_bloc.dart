import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rotary/core/use_cases.dart/use_cases.dart';
import 'package:rotary/data/models/home/home_model.dart';
import 'package:rotary/domain/usecases/event_usecase/get_upcomming_event_usecase.dart';
import 'package:rotary/domain/usecases/home_usecase/get_home_page_data_usecase.dart';
import 'package:rotary/domain/usecases/news_usecase/get_news_usecase.dart';

import '../../../data/models/event/event_response_model.dart';
import '../../../data/models/news/news_response_model.dart';

part 'homepage_event.dart';
part 'homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  GetHomePageUSeCase getHomePageUSeCase;
  GetNewsUseCase getNewsUseCase;
  GetUpcommingEventUseCase getUpcommingEventUseCase;
  HomepageBloc(this.getHomePageUSeCase, this.getNewsUseCase,
      this.getUpcommingEventUseCase)
      : super(HomepageInitial()) {
    on<HomepageEvent>((event, emit) {});
    on<GetHomePageDataEvent>((event, emit) async {
      NewsResponseModel? newsModel;
      EventResponseModel? upcommingEventModel;
      emit(HomepageLoading());
      await getHomePageUSeCase.call(NoParams()).then((either) {
        either.fold(
          (failure) => emit(HomepageError(message: failure.failureMessage)),
          (r) => homeModel = r,
        );
      });
      await getNewsUseCase.call(NoParams()).then((either) {
        either.fold(
          (f) => emit(HomepageError(message: f.failureMessage)),
          (r) => newsModel = r,
        );
      });

      await getUpcommingEventUseCase.call(NoParams()).then((either) {
        either.fold(
          (f) => emit(HomepageError(message: f.failureMessage)),
          (r) => upcommingEventModel = r,
        );
      });

      if (homeModel != null &&
          newsModel != null &&
          upcommingEventModel != null) {
        emit(HomepageLoaded(
            homeModel: homeModel!,
            newsModel: newsModel!,
            upcommingEventModel: upcommingEventModel!));
      }
    });
  }
  HomeModel? homeModel;
}
