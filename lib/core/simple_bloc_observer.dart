import 'package:bloc/bloc.dart';

// We can extend `BlocObserver` and override `onTransition` and `onError`
// in order to handle transitions and errors from all Blocs.
class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print("Added Event ##############>>>>>>>${event.toString()}\n");
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print("FROM ##############>>>>>>>${transition.currentState.toString()}\n"
        "TO  ##############>>>>>>>${transition.nextState.toString()}");
    super.onTransition(bloc, transition);
  }
}
