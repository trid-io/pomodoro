extension SecondHelper on int {
  String formatSecond() {
    final int sec = this % 60;
    final int min = (this / 60).floor();
    return "${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}";
  }
}
