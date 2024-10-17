import 'package:flutter/material.dart';

/// This is the animated draggable icon
class CustomAnimatedIcon extends StatelessWidget {
  const CustomAnimatedIcon(
      {super.key,
      required this.translationY,
      required this.scaledSize,
      required this.icon});

  final double translationY;
  final double scaledSize;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 200,
      ),
      transform: Matrix4.identity()
        ..translate(
          0.0,
          translationY,
          0.0,
        ),
      height: scaledSize,
      width: scaledSize,
      alignment: AlignmentDirectional.bottomCenter,
      padding: const EdgeInsets.all(8),
      constraints: const BoxConstraints(
        minWidth: 48,
        minHeight: 48,
      ),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.primaries[icon.hashCode % Colors.primaries.length],
      ),
      child: FittedBox(
        fit: BoxFit.contain,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(
            milliseconds: 300,
          ),
          style: TextStyle(
            fontSize: scaledSize,
          ),
          child: Center(
              child: Icon(
            icon,
            color: Colors.white,
            size: scaledSize,
          )),
        ),
      ),
    );
  }
}
