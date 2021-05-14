extension DurationExtention on Duration {
  String get displayedText {
    final hours = inHours;
    final minutes = inMinutes - inHours * Duration.minutesPerHour;
    final displayedHours = hours < 10 ? '0$hours' : hours;
    final displayedMinutes = minutes < 10 ? '0$minutes' : minutes;
    return '$displayedHours:$displayedMinutes';
  }

  String get toJsonText => '$displayedText';
}
