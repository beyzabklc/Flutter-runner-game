import 'package:flame/flame.dart';
import 'package:flutter/widgets.dart';

import 'app.dart';
import 'data/high_score_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();

  final highScoreRepository = await HighScoreRepository.create();

  runApp(RunnerApp(highScoreRepository: highScoreRepository));
}