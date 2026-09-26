import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/high_score_repository.dart';

class HighScoreCubit extends Cubit<int> {
  final HighScoreRepository _repository;

  HighScoreCubit(this._repository) : super(_repository.load());

  Future<void> submitScore(int score) async {
    if (score <= state) return;

    emit(score);
    await _repository.save(score);
  }
}