extension DateFormatting on DateTime {
  String toShortDate() {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[month - 1]} $day';
  }

  String toFormattedDate() {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[month - 1]} $day, $year';
  }
}

extension StringDateParsing on String {
  String toShortDate() {
    if (isEmpty) return '';
    try {
      final parsed = DateTime.parse(this);
      return parsed.toShortDate();
    } catch (_) {
      return this;
    }
  }

  String toFormattedDate() {
    if (isEmpty) return '';
    try {
      final parsed = DateTime.parse(this);
      return parsed.toFormattedDate();
    } catch (_) {
      return this;
    }
  }
}
