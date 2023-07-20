import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_bar_app/progress_screen/bloc/progress_bloc.dart';
import 'package:progress_bar_app/splash_screen/screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProgressBloc(),
      child: const MaterialApp(
        title: 'Impacx',
        home: SplashScreen()
      ),
    );
  }
}

