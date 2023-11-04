extension DateTimeFormatter on DateTime {
  String formatGeneral() {
    return '$year.$month.$day ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}';
  }

  String getElapsedTimeFormatted() {
    final now = DateTime.now().toUtc().add(const Duration(hours: 9));
    final elapsed = now.difference(this);

    final inMinutes = elapsed.inMinutes;
    if (inMinutes < 120) {
      return '$inMinutes분 전';
    }

    final inHours = elapsed.inHours;
    if (inHours < 72) {
      return '$inHours시간 ${inMinutes % 60}분 전';
    }

    final inDays = elapsed.inDays;
    return '$inDays일 ${inHours % 24}시간 전';
  }
}

