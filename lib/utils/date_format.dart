import 'package:intl/intl.dart';

class DateFormatSuport {
  static formatStringDate(String date, String format) {
    var formatter = new DateFormat(format);
    String dateFormatted = formatter.format(DateTime.parse(date));
    return dateFormatted;
  }
}
