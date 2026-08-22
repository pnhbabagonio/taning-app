import 'package:flutter/material.dart';

class LinearProgressBar extends StatelessWidget {
  final double progress;
  final Color color;
  final double height;
  final BorderRadius? borderRadius;

  const LinearProgressBar({
    super.key,
    required this.progress,
    required this.color,
    this.height = 4,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(height / 2),
      child: LinearProgressIndicator(
        value: progress.clamp(0.0, 1.0),
        backgroundColor: Colors.grey.shade200,
        valueColor: AlwaysStoppedAnimation<Color>(color),
        minHeight: height,
      ),
    );
  }
}

class CircularRingProgress extends StatelessWidget {
  final double progress;
  final Color color;
  final double size;
  final double strokeWidth;
  final Widget? center;

  const CircularRingProgress({
    super.key,
    required this.progress,
    required this.color,
    this.size = 60,
    this.strokeWidth = 4,
    this.center,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            strokeWidth: strokeWidth,
            backgroundColor: Colors.grey.shade200,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
          if (center != null) center!,
        ],
      ),
    );
  }
}