import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/high_score_repository.dart';
import 'state/high_score_cubit.dart';
import 'ui/game_screen.dart';

class RunnerApp extends StatelessWidget {
  final HighScoreRepository highScoreRepository;

  const RunnerApp({super.key, required this.highScoreRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HighScoreCubit(highScoreRepository),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: GameScreen(),
      ),
    );
  }
}