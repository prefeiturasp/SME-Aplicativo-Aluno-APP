import 'package:html/parser.dart';

class StringSupport {
  static String truncateEndString(String text, int count) {
    const String elepsis = '...';
    if (text.length >= count) {
      return text.substring(0, count - elepsis.length) + elepsis;
    }
    return text;
  }

  static String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body!.text).documentElement!.text;
    return parsedString;
  }

  static String formatStringPhoneNumber(String value) {
    final String valueFormated =
        value.replaceAllMapped(RegExp(r'(\d{2})(\d{5})(\d+)'), (Match m) => '(${m[1]}) ${m[2]}-${m[3]}');
    return valueFormated;
  }

  static String replaceEmailSecurity(String oldString, int startIndex) {
    final end = oldString.indexOf(RegExp(r'@'));

    return oldString.replaceRange(startIndex, end, '*********');
  }
}
