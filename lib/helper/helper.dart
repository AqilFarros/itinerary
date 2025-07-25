import 'package:flutter/material.dart';
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
}
