import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  final MaterialColor color;
  final Widget child;
  const GradientContainer({
    required this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
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
      child: this.child,
    );
  }
}