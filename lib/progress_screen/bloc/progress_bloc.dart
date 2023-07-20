import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

import 'progress_event.dart';
import 'progress_state.dart';

// Bloc class for the progress animation
class ProgressBloc extends Bloc<ProgressEvent, ProgressState> {
  ProgressBloc() : super(InitialProgressState());

  @override
  Stream<ProgressState> mapEventToState(ProgressEvent event) async* {
    if (event is StartProgressEvent) {
      for (int i = 1; i <= 100; i++) {
        await Future.delayed(const Duration(milliseconds: 100));
        yield ProgressInLoadingState(i / 100);
      }

      yield ProgressCompleteState();
    }
  }
}
