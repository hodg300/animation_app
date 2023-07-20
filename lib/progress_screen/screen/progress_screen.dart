import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_bar_app/utils/utils.dart';

import '../../utils/colors.dart';
import '../bloc/progress_bloc.dart';
import '../bloc/progress_event.dart';
import '../bloc/progress_state.dart';
import '../paint/half_circle_painter.dart';

// This class with Bloc !
class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  Widget _buildPercentCounter(BuildContext context, double progress) {
    return Stack(alignment: Alignment.centerLeft, children: [
      SizedBox(
        height: Utils.screenWidthSize(context) * 0.26,
        child: CustomPaint(
          painter: HalfCirclePainter(
              animationValue: 1.0,
              startColor: Colors.grey.shade300,
              endColor: Colors.grey.shade300,
              setBoxShadow: true),
        ),
      ),
      Positioned(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: Text("${(progress * 100).toInt()}%",
            style: const TextStyle(
                fontSize: 12,
                decoration: TextDecoration.none,
                color: Colors.black)),
      ))
    ]);
  }

  Widget _buildProgressAnimationWithImage(
      BuildContext context, double progress) {
    return Stack(
      children: [
        Positioned(
          left: Utils.screenWidthSize(context) * 0.02,
          top: Utils.screenHeightSize(context) * 0.2,
          child: SizedBox(
            height: Utils.screenWidthSize(context) * 0.72,
            child: CustomPaint(
              painter: HalfCirclePainter(
                  animationValue: progress,
                  startColor: AppColors.blue,
                  endColor: AppColors.darkBlue),
            ),
          ),
        ),
        Positioned(
          left: 0,
          top: Utils.screenHeightSize(context) * 0.2,
          child: Image.asset(
            'images/progress.png', // Replace with your image path
            width: Utils.screenWidthSize(context) * 0.39,
            height: Utils.screenWidthSize(context) * 0.745,
          ),
        ),
        Positioned(
            left: 0,
            top: Utils.screenHeightSize(context) * 0.315,
            child: _buildPercentCounter(context, progress))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProgressBloc()..add(StartProgressEvent()),
      child: Container(
        color: Colors.white,
        height: Utils.screenHeightSize(context),
        width: Utils.screenWidthSize(context),
        child: BlocBuilder<ProgressBloc, ProgressState>(
          builder: (context, state) {
            if (state is ProgressInLoadingState) {
              // fetch the progress value from the state
              return _buildProgressAnimationWithImage(context, state.progress);
            } else if (state is ProgressCompleteState) {
              return _buildProgressAnimationWithImage(context, 1);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
