import 'package:shared_preferences/shared_preferences.dart';

// سرویس ذخیره‌سازی پیشرفت کاربر در یادگیری حروف
class ProgressService {
  // کلیدی برای ذخیره تعداد حروف یادگرفته‌شده در حافظه‌ی محلی
  static const _key = 'learned_letters';

  // گرفتن تعداد حروفی که کاربر تا الان یاد گرفته
  static Future<int> getLearnedCount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_key) ?? 0; // اگر چیزی ذخیره نشده بود، صفر برمی‌گردونه
  }

  // به‌روزرسانی تعداد حروف یادگرفته‌شده (اگر عدد جدید بیشتر باشه)
  static Future<void> updateLearnedCount(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getInt(_key) ?? 0;
    if (index >= current) {
      await prefs.setInt(_key, index + 1);
    }
  }

  // بررسی اینکه آیا همه‌ی حروف یاد گرفته شده‌اند یا نه
  static Future<bool> isAllLettersLearned(int totalCount) async {
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getInt(_key) ?? 0;
    return current >= totalCount;
  }
}
