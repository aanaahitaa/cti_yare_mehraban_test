import 'package:shared_preferences/shared_preferences.dart';

class ProgressService {
  static const _key = 'learned_letters';

  static Future<int> getLearnedCount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_key) ?? 0;
  }

  static Future<void> updateLearnedCount(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getInt(_key) ?? 0;
    if (index >= current) {
      await prefs.setInt(_key, index + 1);
    }
  }
}
