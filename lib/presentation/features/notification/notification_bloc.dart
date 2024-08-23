import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rotary/core/use_cases.dart/use_cases.dart';
import 'package:rotary/data/models/notification/notification_response.dart';
import 'package:rotary/presentation/features/home_page_bloc/homepage_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/usecases/notification/mark_read_all_notification_usecase.dart';
import '../../../domain/usecases/notification/mark_read_notification_usecase.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  MarkReadAllNotificationUseCase markReadAllNotificationUseCase;
  MarkReadNotificationUseCase markReadNotificationUseCase;
  HomepageBloc homepageBloc;
  // AuthBloc authBloc;

  BehaviorSubject<NotificationResponseModel> notificationRx =
      BehaviorSubject<NotificationResponseModel>();
  NotificationBloc(this.markReadAllNotificationUseCase,
      this.markReadNotificationUseCase, this.homepageBloc)
      : super(NotificationInitial()) {
    homepageBloc.stream.listen((event) {
      print(event);
      if (event is HomepageLoaded) {
        homepageBloc.homeModel != null
            ? notificationRx.sink.add(homepageBloc.homeModel!.notification!)
            : null;
      }
    });

    // authBloc.stream.listen((state) {
    //   if(state is AuthSuccess) {
    //     if(!state.isAuthenticated) {
    //       add(CheckTokenExist());
    //     }
    //   }
    // });

    on<NotificationEvent>((event, emit) {
      if (event is MarkReadEvent) {
        _markRead(event.notificationId);
      } else if (event is MarkAllReadEvent) {
        _markReadAll();
      }
    });
  }
  _markRead(String notificationId) async {
    final result = await markReadNotificationUseCase.call(notificationId);
    result.fold(
      (l) => notificationRx.addError(l.failureMessage),
      (r) => notificationRx.add(r),
    );
  }

  _markReadAll() {
    final result = markReadAllNotificationUseCase.call(NoParams());
    result.then((value) {
      if (value.isLeft()) {
        notificationRx.addError(value);
      } else {
        NotificationResponseModel nrm = NotificationResponseModel();
        notificationRx.add(nrm);
      }
    });
  }
}
