import "package:html/parser.dart";

class StringSupport {
  static truncateEndString(String text, int count) {
    String elepsis = "...";
    if (text.length >= count) {
      return text.substring(0, count - elepsis.length) + elepsis;
    }
    return text;
  }

  static String parseHtmlString(String htmlString) {
    var document = parse(htmlString);
    String parsedString = parse(document.body.text).documentElement.text;
    return parsedString;
  }

  static String formatStringPhoneNumber(String value) {
    String valueFormated = value.replaceAllMapped(
        RegExp(r'(\d{2})(\d{5})(\d+)'),
        (Match m) => "(${m[1]}) ${m[2]}-${m[3]}");
    return valueFormated;
  }
}
