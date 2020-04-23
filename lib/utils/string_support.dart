class StringSupport {
  static truncateEndString(String text, int count) {
    String elepsis = "...";
    if (text.length >= count) {
      return text.substring(0, count - elepsis.length) + elepsis;
    }
    return text;
  }
}
