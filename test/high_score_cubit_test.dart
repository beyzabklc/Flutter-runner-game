import 'package:flutter_test/flutter_test.dart';
import 'package:marsky_runner/data/high_score_repository.dart';
import 'package:marsky_runner/state/high_score_cubit.dart';

class FakeHighScoreRepository implements HighScoreRepository {
  int savedScore;

  FakeHighScoreRepository(this.savedScore);

  @override
  int load() => savedScore;

  @override
  Future<void> save(int score) async {
    savedScore = score;
  }
}

void main() {
  group('HighScoreCubit', () {
    test('starts with the saved high score', () {
      final cubit = HighScoreCubit(FakeHighScoreRepository(120));
      addTearDown(cubit.close);

      expect(cubit.state, 120);
    });

    test('saves a new high score', () async {
      final repository = FakeHighScoreRepository(120);
      final cubit = HighScoreCubit(repository);
      addTearDown(cubit.close);

      await cubit.submitScore(200);

      expect(cubit.state, 200);
      expect(repository.savedScore, 200);
    });

    test('ignores scores that are not higher', () async {
      final repository = FakeHighScoreRepository(120);
      final cubit = HighScoreCubit(repository);
      addTearDown(cubit.close);

      await cubit.submitScore(50);
      await cubit.submitScore(120);

      expect(cubit.state, 120);
      expect(repository.savedScore, 120);
    });
  });
}