import 'package:shared_preferences/shared_preferences.dart';

class HighScoreRepository {
  static const String _key = 'high_score';

  final SharedPreferencesWithCache _prefs;

  HighScoreRepository._(this._prefs);

  static Future<HighScoreRepository> create() async {
    final prefs = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        allowList: {_key},
      ),
    );
    return HighScoreRepository._(prefs);
  }

  int load() => _prefs.getInt(_key) ?? 0;

  Future<void> save(int score) => _prefs.setInt(_key, score);
}