import 'package:intl/intl.dart';

class Helper {
  static String formatDate(DateTime date) {
    return DateFormat('dd MMMM yyyy').format(date);
  }

  static DateTime formatDateToISO8601(String date) {
    DateTime parsedData = DateFormat('dd MMMM yyyy').parse(date);
    String iso8601 = parsedData.toIso8601String();
    return DateTime.parse(iso8601);
  }

  static int convertToMinute(String time) {
    time = time.replaceAll('.', ':').trim().toUpperCase();

    bool isPM = time.contains('PM');
    bool isAM = time.contains('AM');

    time = time.replaceAll(RegExp(r'AM|PM'), '').trim();

    List<String> parts = time.split(':');

    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);

    if (isPM && hour < 12) hour += 12;
    if (isAM && hour == 12) hour = 0;

    return hour * 60 + minute;
  }

  static String minuteToHour(int minute) {
    DateTime baseTime = DateTime(2000, 1, 1);
    DateTime dateTime = baseTime.add(Duration(minutes: minute));

    String formatted = DateFormat.jm().format(dateTime);

    return formatted;
  }
}
