import 'package:flutter/material.dart';

class AccessibilityUtils {
  static SemanticsProperties getCountdownSemantics(
    String title,
    String remaining,
    double? progress,
  ) {
    var label = '$title: $remaining remaining';
    if (progress != null) {
      final percent = (progress * 100).toStringAsFixed(0);
      label += ', $percent percent complete';
    }
    
    return SemanticsProperties(
      label: label,
      value: remaining,
      hint: 'Countdown to $title',
    );
  }

  static SemanticsProperties getCardSemantics(
    String title,
    String status,
  ) {
    return SemanticsProperties(
      label: title,
      value: status,
      hint: 'Tap to view details',
    );
  }
}

/// Accessible button widget
class AccessibleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final String? label;
  final String? hint;

  const AccessibleButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.label,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      hint: hint ?? 'Double tap to activate',
      child: GestureDetector(
        onTap: onPressed,
        child: child,
      ),
    );
  }
}

/// Accessible countdown display
class AccessibleCountdown extends StatelessWidget {
  final String title;
  final String value;
  final double? progress;
  final Widget child;

  const AccessibleCountdown({
    super.key,
    required this.title,
    required this.value,
    this.progress,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$title: $value',
      value: value,
      hint: 'Countdown timer',
      child: child,
    );
  }
}