import 'package:flutter/material.dart';
import 'package:progress_bar_app/progress_screen/screen/progress_screen.dart';

import '../../utils/utils.dart';

// This class without Bloc
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final int animationDuration = 3000;
  final String developerName = 'Hod Gohasi';
  late AnimationController _controller;
  double _position = 1.0; // Initial position is at the bottom of the screen

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
          milliseconds:
              animationDuration ?? 3000), // Total duration for one loop
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // Reset the animation and move to next screen
          _controller.reset();
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const ProgressScreen()),
          );
        }
      });

    // Start the initial animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            // Custom tween sequence with three segments
            final tween = TweenSequence([
              TweenSequenceItem(
                  tween: Tween(begin: 0.0, end: 3 / 4), weight: 1 / 6),
              // Initial pause
              TweenSequenceItem(
                  tween: Tween(begin: 3 / 4, end: 3 / 4), weight: 1 / 2),
              // Pause at 3/4 screen height
              TweenSequenceItem(
                  tween: Tween(begin: 3 / 4, end: 1.0), weight: 1 / 6),
              // Animation up
            ]);

            // Update the position based on the animation value
            _position = tween.evaluate(_controller);

            return Stack(
              children: [
                Positioned(
                  top: Utils.screenHeightSize(context) * (1 - _position),
                  child: SizedBox(
                    width: Utils.screenWidthSize(context),
                    child: Center(
                      child: DefaultTextStyle(
                        style: const TextStyle(
                            fontSize: 32.0, color: Colors.black),
                        child: Text(developerName ?? ""),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
