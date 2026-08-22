import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:taning/features/tanings/domain/entities/taning.dart';
import 'package:intl/intl.dart';

class ShareService {
  static Future<void> shareTaning(BuildContext context, Taning taning) async {
    try {
      final shareText = '''
🎯 ${taning.title}

${_getTypeLabel(taning.type)}
${_getDateLabel(taning)}

Know your taning.
---
Taning - Make time visible.
''';

      await Share.share(
        shareText,
        subject: 'My Taning: ${taning.title}',
      );
    } catch (e) {
      // Fallback to simple share
      try {
        await Share.share(
          'Check out my Taning: ${taning.title}!',
          subject: 'My Taning',
        );
      } catch (_) {
        // Silent fail
      }
    }
  }

  static String _getTypeLabel(TaningType type) {
    switch (type) {
      case TaningType.countdown:
        return '📅 Countdown';
      case TaningType.duration:
        return '⏱️ Duration';
      case TaningType.countUp:
        return '📈 Count Up';
      case TaningType.recurring:
        return '🔄 Recurring';
    }
  }

  static String _getDateLabel(Taning taning) {
    if (taning.type == TaningType.countUp && taning.startDate != null) {
      return '📅 Since: ${_formatDate(taning.startDate!)}';
    }
    if (taning.type == TaningType.duration) {
      final start = taning.startDate != null ? _formatDate(taning.startDate!) : '';
      final end = taning.endDate != null ? _formatDate(taning.endDate!) : '';
      return '📅 $start → $end';
    }
    if (taning.endDate != null) {
      return '📅 Target: ${_formatDate(taning.endDate!)}';
    }
    return '📅 Date not set';
  }

  static String _formatDate(DateTime date) {
    final formatter = date.hour == 0 && date.minute == 0
        ? DateFormat('MMM d, y')
        : DateFormat('MMM d, y h:mm a');
    return formatter.format(date);
  }
}