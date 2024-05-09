int calculateReadingTime(String content) {
  final wordCount = content.split(RegExp(r'\s+')).length;
  final readingTime = (wordCount / 225).ceil();
  return readingTime;
}
