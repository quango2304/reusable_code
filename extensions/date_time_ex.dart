extension DateTimeExtensions on DateTime {
  bool isBetween({required DateTime startAt, required DateTime endAt}) {
    return startAt.isBefore(this) && endAt.isAfter(this);
  }

  bool get isToday {
    if (toLocal().isAfter(startOfToday()) && toLocal().isBefore(endOfToday())) {
      return true;
    }
    return false;
  }

  bool get isPassed {
    return toLocal().isBefore(DateTime.now());
  }

  DateTime startOfToday() {
    final _now = DateTime.now();
    return DateTime(_now.year, _now.month, _now.day);
  }

  DateTime endOfToday() {
    final _now = DateTime.now();
    return DateTime(_now.year, _now.month, _now.day, 23, 59, 59, 999, 999);
  }
}