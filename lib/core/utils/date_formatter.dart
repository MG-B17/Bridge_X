import 'package:intl/intl.dart';

class DateFormatter {
  static String formatTaskDueDate(DateTime? date) {
    if (date == null) return 'No due date';
    return DateFormat('MMM dd, yyyy').format(date);
  }

  static String formatMessageTime(DateTime? date) {
    if (date == null) return '';
    return DateFormat('hh:mm a').format(date);
  }

  static String formatRelativeDate(DateTime? date) {
    if (date == null) return '';
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today, ${formatMessageTime(date)}';
    } else if (difference.inDays == 1) {
      return 'Yesterday, ${formatMessageTime(date)}';
    } else if (difference.inDays < 7) {
      return DateFormat('EEEE').format(date); // E.g., "Monday"
    } else {
      return DateFormat('MMM dd, yyyy').format(date);
    }
  }
}
