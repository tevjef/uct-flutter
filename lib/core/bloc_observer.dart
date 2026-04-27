import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

class AppBlocObserver extends BlocObserver {
  final _log = Logger('BlocObserver');

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    _log.fine('${bloc.runtimeType} $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    _log.severe('${bloc.runtimeType} $error $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}
