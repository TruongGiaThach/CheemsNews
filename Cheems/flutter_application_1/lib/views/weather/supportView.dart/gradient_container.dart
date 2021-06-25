import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  final MaterialColor color;

  const GradientContainer({
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0, 1.0],
          colors: [
            color.shade800,
            color.shade400,
          ],
        ),
      ),
    );
  }
}
