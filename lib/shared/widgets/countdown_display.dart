import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taning/features/settings/presentation/providers/settings_providers.dart';
import 'package:taning/features/tanings/domain/entities/taning.dart';

class CountdownDisplay extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final Color effectiveColor = color ?? ref.watch(accentColorProvider);

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

    switch (style) {
      case CountdownStyle.simple:
        return _buildCompactDisplay(effectiveColor, includeSeconds: false);
      case CountdownStyle.detailed:
        return _buildCompactDisplay(effectiveColor, includeSeconds: true);
      case CountdownStyle.full:
        return _buildFullDisplay(effectiveColor);
      case CountdownStyle.progress:
      case CountdownStyle.calendar:
        return const SizedBox.shrink();
    }
  }

  Widget _buildCompactDisplay(Color color, {required bool includeSeconds}) {
    final parts = _getParts(includeSeconds: includeSeconds);
    if (parts.isEmpty) {
      return Text(
        '0s',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      );
    }
    final text = parts.map((p) => '${p.value}${p.unit[0]}').join(' ');
    return Text(
      text,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: color,
      ),
    );
  }

  Widget _buildFullDisplay(Color color) {
    final parts = _getParts(includeSeconds: true);
    if (parts.isEmpty) {
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
      children: parts.map((p) {
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

  List<_DisplayPart> _getParts({required bool includeSeconds}) {
    final days = duration.inDays;
    final hours = duration.inHours.remainder(24);
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    final parts = <_DisplayPart>[];

    if (days > 0) {
      parts.add(_DisplayPart(days, 'days'));
    }
    if (hours > 0 || days > 0) {
      parts.add(_DisplayPart(hours, 'hours'));
    }
    if (minutes > 0 || hours > 0 || days > 0) {
      parts.add(_DisplayPart(minutes, 'minutes'));
    }
    if (includeSeconds) {
      parts.add(_DisplayPart(seconds, 'seconds'));
    }

    return parts;
  }
}

class _DisplayPart {
  final int value;
  final String unit;
  const _DisplayPart(this.value, this.unit);
}