import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taning/features/settings/presentation/providers/settings_providers.dart';
import 'package:taning/features/tanings/domain/entities/taning.dart';

/// A widget that displays a countdown duration in various styles.
class CountdownDisplay extends ConsumerWidget {
  final Duration duration;
  final CountdownStyle style;

  /// If provided, uses this color. Otherwise falls back to the
  /// global accent color from settings.
  final Color? color;

  final bool isOverdue;
  final bool isFinished;

  const CountdownDisplay({
    super.key,
    required this.duration,
    this.style = CountdownStyle.detailed,
    this.color,
    this.isOverdue = false,
    this.isFinished = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use provided color, or fall back to global accent.
    // Then coerce to non-nullable with a final fallback.
    final Color effectiveColor =
        color ?? ref.watch(accentColorProvider);

    if (isFinished) {
      return const Text(
        '✅ Done',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: Colors.green,
        ),
      );
    }

    if (isOverdue) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${duration.inDays.abs()} days overdue',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.red,
            ),
          ),
          const Text(
            'Time has passed',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      );
    }

    final parts = _getDisplayParts(duration, style);

    switch (style) {
      case CountdownStyle.simple:
      case CountdownStyle.detailed:
        // Both use the same compact display.
        // The difference is refresh rate, handled by the caller's ticker.
        return _buildCompactDisplay(parts, effectiveColor);
      case CountdownStyle.full:
        return _buildFullDisplay(parts, effectiveColor);
      case CountdownStyle.progress:
      case CountdownStyle.calendar:
        return const SizedBox.shrink();
    }
  }

  /// Compact display: "14d 6h 42m" — one line.
  Widget _buildCompactDisplay(List<_DisplayPart> parts, Color color) {
    final filtered = parts.where((p) => p.value > 0).toList();
    if (filtered.isEmpty) {
      return Text(
        '0s',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      );
    }
    final text = filtered.map((p) => '${p.value}${p.unit[0]}').join(' ');
    return Text(
      text,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: color,
      ),
    );
  }

  /// Full display: one unit per line.
  Widget _buildFullDisplay(List<_DisplayPart> parts, Color color) {
    final filtered = parts.where((p) => p.value > 0).toList();
    if (filtered.isEmpty) {
      return Text(
        '0s',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: filtered.map((p) {
        final isPrimary = p.unit == 'days';
        return Text(
          '${p.value} ${p.unit}',
          style: TextStyle(
            fontSize: isPrimary ? 28 : 18,
            fontWeight: isPrimary ? FontWeight.w700 : FontWeight.w500,
            color: isPrimary ? color : color.withValues(alpha: 0.7),
            height: 1.2,
          ),
        );
      }).toList(),
    );
  }

  List<_DisplayPart> _getDisplayParts(Duration duration, CountdownStyle style) {
    final days = duration.inDays;
    final hours = duration.inHours.remainder(24);
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    final parts = <_DisplayPart>[];

    // Simple and Detailed: hide seconds.
    // Full: show seconds.
    if (days > 0 || style == CountdownStyle.full) {
      parts.add(_DisplayPart(days, 'days'));
    }
    if (hours > 0 || style == CountdownStyle.full) {
      parts.add(_DisplayPart(hours, 'hours'));
    }
    if (minutes > 0 || style == CountdownStyle.full) {
      parts.add(_DisplayPart(minutes, 'minutes'));
    }
    if (style == CountdownStyle.full) {
      parts.add(_DisplayPart(seconds, 'seconds'));
    }

    if (parts.isEmpty) {
      parts.add(_DisplayPart(0, 'seconds'));
    }
    return parts;
  }
}

class _DisplayPart {
  final int value;
  final String unit;
  const _DisplayPart(this.value, this.unit);
}