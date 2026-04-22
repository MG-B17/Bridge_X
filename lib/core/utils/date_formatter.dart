import 'package:intl/intl.dart';

class DateFormatter {
  static String formatTaskDueDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('MMM d, yyyy').format(date);
  }

  static String formatMessageTime(DateTime? date) {
    if (date == null) return '';
    return DateFormat('HH:mm').format(date);
  }

  static String formatTimestamp(int? timestampMs) {
    if (timestampMs == null) return '';
    return formatMessageTime(DateTime.fromMillisecondsSinceEpoch(timestampMs));
  }
}
