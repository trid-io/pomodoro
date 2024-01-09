import 'package:flutter/widgets.dart';

class PomoTime extends StatelessWidget {
  const PomoTime({
    super.key,
    required this.displayTime,
    required this.color,
    double? size,
  }) : size = size ?? 50;

  final String displayTime;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      displayTime,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
