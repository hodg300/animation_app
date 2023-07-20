// States for the progress animation
abstract class ProgressState {}

class InitialProgressState extends ProgressState {}

class ProgressInLoadingState extends ProgressState {
  final double progress;

  ProgressInLoadingState(this.progress);
}

class ProgressCompleteState extends ProgressState {}