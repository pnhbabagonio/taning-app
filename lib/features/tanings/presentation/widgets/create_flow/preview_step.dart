import 'package:flutter/material.dart';
import 'package:taning/features/tanings/domain/entities/taning.dart';
import 'package:intl/intl.dart';
import 'package:taning/features/tanings/presentation/view_models/create_view_model.dart';
import 'package:taning/features/tanings/presentation/widgets/taning_card.dart';

class PreviewStep extends StatelessWidget {
  final CreateViewModel viewModel;
  final VoidCallback onBack;
  final VoidCallback onCreate;

  const PreviewStep({
    super.key,
    required this.viewModel,
    required this.onBack,
    required this.onCreate,
  });

  @override
  Widget build(BuildContext context) {
    final taning = viewModel.buildTaning();

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            'Preview',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Review your Taning before creating',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: Center(
              child: TaningCard(
                taning: taning,
                variant: TaningCardVariant.focus,
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Summary
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildSummaryRow(
                    'Type',
                    _getTypeLabel(taning.type),
                  ),
                  _buildSummaryRow(
                    'Date',
                    _getDateLabel(taning),
                  ),
                  if (taning.type == TaningType.duration)
                    _buildSummaryRow(
                      'Duration',
                      _getDurationLabel(taning),
                    ),
                  _buildSummaryRow(
                    'Notifications',
                    _getNotificationLabel(taning.notificationSettings),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onBack,
                  child: const Text('Back'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: onCreate,
                  child: const Text('Create Taning'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  String _getTypeLabel(TaningType type) {
    switch (type) {
      case TaningType.countdown:
        return 'Countdown';
      case TaningType.duration:
        return 'Duration / Challenge';
      case TaningType.countUp:
        return 'Count Up';
      case TaningType.recurring:
        return 'Recurring';
    }
  }

  String _getDateLabel(Taning taning) {
    if (taning.type == TaningType.countUp && taning.startDate != null) {
      return 'Since ${_formatDate(taning.startDate!)}';
    }
    if (taning.type == TaningType.duration) {
      final start = taning.startDate != null ? _formatDate(taning.startDate!) : '';
      final end = taning.endDate != null ? _formatDate(taning.endDate!) : '';
      return '$start → $end';
    }
    if (taning.endDate != null) {
      return _formatDate(taning.endDate!);
    }
    return 'Not set';
  }

  String _getDurationLabel(Taning taning) {
    if (taning.startDate != null && taning.endDate != null) {
      final days = taning.endDate!.difference(taning.startDate!).inDays;
      return '$days days';
    }
    return 'Not set';
  }

  String _getNotificationLabel(NotificationSettings settings) {
    if (!settings.enabled) return 'Off';
    final reminders = <String>[];
    if (settings.oneDayBefore) reminders.add('1d');
    if (settings.threeDaysBefore) reminders.add('3d');
    if (settings.sevenDaysBefore) reminders.add('7d');
    if (settings.oneHourBefore) reminders.add('1h');
    if (settings.thirtyMinutesBefore) reminders.add('30m');
    if (settings.atExactTime) reminders.add('Exact');
    return reminders.isEmpty ? 'On (default)' : reminders.join(', ');
  }

  String _formatDate(DateTime date) {
    final formatter = date.hour == 0 && date.minute == 0
        ? DateFormat('MMM d, y')
        : DateFormat('MMM d, y h:mm a');
    return formatter.format(date);
  }
}