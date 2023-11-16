import 'package:intl/intl.dart';

class DateFormatSuport {
  static String formatStringDate(String date, String format) {
    final formatter = DateFormat(format);
    final String dateFormatted = formatter.format(DateTime.parse(date));
    return dateFormatted;
  }
}
