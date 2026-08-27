import 'package:flutter/material.dart';
import 'package:taning/features/tanings/domain/entities/taning.dart';

/// A widget that displays a countdown duration in various styles.
class CountdownDisplay extends StatelessWidget {
  final Duration duration;
  final CountdownStyle style;
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
  Widget build(BuildContext context) {
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
            style: TextStyle(
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
    final textColor = color ?? Theme.of(context).textTheme.bodyLarge?.color;

    switch (style) {
      case CountdownStyle.simple:
        return _buildSimpleDisplay(parts, textColor);
      case CountdownStyle.detailed:
        return _buildDetailedDisplay(parts, textColor);
      case CountdownStyle.full:
        return _buildFullDisplay(parts, textColor);
      case CountdownStyle.progress:
        // Not used here; handled separately
        return const SizedBox.shrink();
      case CountdownStyle.calendar:
        // Not used here; handled separately
        return const SizedBox.shrink();
    }
  }

  Widget _buildSimpleDisplay(List<_DisplayPart> parts, Color? color) {
    // Show the largest unit
    final part = parts.firstWhere(
      (p) => p.value > 0,
      orElse: () => parts.last,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          part.value.toString(),
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: color,
            height: 1.0,
          ),
        ),
        Text(
          part.unit,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailedDisplay(List<_DisplayPart> parts, Color? color) {
    // Show days, hours, minutes in a single line (or as appropriate)
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

  Widget _buildFullDisplay(List<_DisplayPart> parts, Color? color) {
    // Show each unit on its own line (or a column)
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
        return Text(
          '${p.value} ${p.unit}',
          style: TextStyle(
            fontSize: p.unit == 'days' ? 28 : 18,
            fontWeight: p.unit == 'days' ? FontWeight.w700 : FontWeight.w500,
            color: color,
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
    if (days > 0 || style == CountdownStyle.full) {
      parts.add(_DisplayPart(days, 'days'));
    }
    if (hours > 0 || style == CountdownStyle.full) {
      parts.add(_DisplayPart(hours, 'hours'));
    }
    if (minutes > 0 || style == CountdownStyle.full) {
      parts.add(_DisplayPart(minutes, 'minutes'));
    }
    if (seconds > 0 || style == CountdownStyle.full) {
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