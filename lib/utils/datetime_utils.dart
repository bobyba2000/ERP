class DateTimeUtils {
  static bool isEqual(DateTime a, DateTime b) {
    final DateTime aCheck = DateTime(a.year, a.month, a.day);
    final DateTime bCheck = DateTime(b.year, b.month, b.day);
    return aCheck == bCheck;
  }

  static List<DateTime> getListWeeks(DateTime timeStart, DateTime timeEnd) {
    List<DateTime> result = [];
    var date = timeStart;
    while (date.difference(timeEnd).inDays <= 0) {
      result.add(date);
      date = date.add(const Duration(days: 1));
    }
    return result;
  }
}
