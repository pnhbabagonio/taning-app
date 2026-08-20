import 'package:flutter/material.dart';

class ProgressIndicators {
  const ProgressIndicators._();
}

// MARK: - Linear Progress Bar

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

// MARK: - Circular Ring Progress

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

// MARK: - Dot Grid Progress

class DotGridProgress extends StatelessWidget {
  final double progress;
  final Color color;
  final int totalDots;
  final double dotSize;
  final double spacing;

  const DotGridProgress({
    super.key,
    required this.progress,
    required this.color,
    this.totalDots = 30,
    this.dotSize = 8,
    this.spacing = 4,
  });

  @override
  Widget build(BuildContext context) {
    final filledDots = (progress * totalDots).round().clamp(0, totalDots);
    
    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children: List.generate(totalDots, (index) {
        final isFilled = index < filledDots;
        return Container(
          width: dotSize,
          height: dotSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isFilled ? color : Colors.grey.shade200,
          ),
        );
      }),
    );
  }
}

// MARK: - Day Counter Progress

class DayCounterProgress extends StatelessWidget {
  final int currentDay;
  final int totalDays;
  final Color color;

  const DayCounterProgress({
    super.key,
    required this.currentDay,
    required this.totalDays,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final progress = currentDay / totalDays;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Day $currentDay',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'of $totalDays',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressBar(
          progress: progress.clamp(0.0, 1.0),
          color: color,
        ),
        const SizedBox(height: 4),
        Text(
          '${(progress * 100).toStringAsFixed(1)}% complete',
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}