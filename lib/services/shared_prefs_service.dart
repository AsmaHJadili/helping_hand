import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String _difficultyScoreKey = 'child_difficulty_score';
  static const String _prosocialScoreKey = 'child_prosocial_score';

  // جلب النقاط الكلية للصعوبة
  Future<int> getCurrentDifficultyScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_difficultyScoreKey) ?? 0;
  }
  
  // جلب النقاط الكلية لسلوكيات القوة
  Future<int> getCurrentProsocialScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_prosocialScoreKey) ?? 0;
  }

  // إضافة النقاط حسب نوع البعد
  Future<void> addPoints(int points, bool isProsocial) async {
    final prefs = await SharedPreferences.getInstance();
    if (isProsocial) {
      final currentScore = await getCurrentProsocialScore();
      await prefs.setInt(_prosocialScoreKey, currentScore + points);
      print('Prosocial Score Updated: +$points');
    } else {
      final currentScore = await getCurrentDifficultyScore();
      await prefs.setInt(_difficultyScoreKey, currentScore + points);
      print('Difficulty Score Updated: +$points');
    }
  }

  // مسح جميع النتائج لبدء اختبار جديد
  Future<void> clearAllScores() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_difficultyScoreKey);
    await prefs.remove(_prosocialScoreKey);
    print('All Scores Cleared.');
  }
}