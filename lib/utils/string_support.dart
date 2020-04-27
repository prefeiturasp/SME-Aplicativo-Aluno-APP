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
}
