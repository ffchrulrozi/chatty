extension DateExt on DateTime {
  DateTime toStartOfDay() => DateTime(year, month, day);
  DateTime toEndOfDay() => DateTime(year, month, day, 23, 59, 59);
  DateTime toStartOfMonth() => DateTime(year, month, 1, 0, 0, 0);
  String toFormattedDate() {
    final now = DateTime.now().toStartOfDay();
    final date = toStartOfDay();

    final difference = now.difference(date).inDays;

    if (difference == 0) {
      return "$hour:$minute";
    } else if (difference == 1) {
      return "Yesterday";
    } else if (now.month == date.month) {
      return "${date.day} ${date.month}";
    } else if (now.year == date.year) {
      return "${date.day} ${date.month}";
    } else {
      return "${date.day} ${date.month} ${date.year}";
    }
  }
}
