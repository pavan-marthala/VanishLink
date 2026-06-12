import 'package:intl/intl.dart';

/// Generates a deterministic chatId by sorting the user IDs alphabetically and joining them with an underscore.
String getDeterministicChatId(String userId1, String userId2) {
  final list = [userId1, userId2]..sort();
  return list.join('_');
}

/// Formats a DateTime into a compact timestamp text:
/// - If today: "h:mm AM/PM" (e.g. 10:42 AM)
/// - If yesterday: "Yesterday"
/// - Otherwise: "MMM d" (e.g. Jun 12)
String formatCompactTimestamp(DateTime dateTime) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = DateTime(now.year, now.month, now.day - 1);
  final messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

  if (messageDate == today) {
    return DateFormat('h:mm a').format(dateTime);
  } else if (messageDate == yesterday) {
    return 'Yesterday';
  } else {
    return DateFormat('MMM d').format(dateTime);
  }
}
