import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:taning/features/settings/presentation/providers/settings_providers.dart';
import 'package:taning/features/tanings/domain/entities/taning.dart';
import 'package:taning/features/tanings/presentation/view_models/create_view_model.dart';
import 'package:taning/features/tanings/presentation/widgets/taning_card.dart';

class PreviewStep extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final taning = viewModel.buildTaning();
    final accentColor = ref.watch(accentColorProvider);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            'Preview',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          const Text(
            'Review your Taning before creating',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final size = constraints.maxWidth < constraints.maxHeight
                    ? constraints.maxWidth * 0.85
                    : constraints.maxHeight * 0.85;
                final cardSize = size.clamp(200.0, 400.0);
                return Center(
                  child: SizedBox(
                    width: cardSize,
                    height: cardSize,
                    child: TaningCard(
                      taning: taning,
                      variant: TaningCardVariant.focus,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _row('Type', _typeLabel(taning.type)),
                  _row('Date', _dateLabel(taning)),
                  _row('Style', _styleLabel(taning.countdownStyle)),
                  _row('Notifications',
                      _notifLabel(taning.notificationSettings)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom + 8,
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onBack,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: accentColor,
                      side: BorderSide(color: accentColor),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Back'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onCreate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Create Taning'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          const Spacer(),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _typeLabel(TaningType t) {
    switch (t) {
      case TaningType.countdown:
        return 'Countdown';
      case TaningType.duration:
        return 'Duration';
      case TaningType.countUp:
        return 'Count Up';
      case TaningType.recurring:
        return 'Recurring';
    }
  }

  String _styleLabel(CountdownStyle s) {
    switch (s) {
      case CountdownStyle.detailed:
        return 'Detailed';
      default:
        return 'Simple';
    }
  }

  String _dateLabel(Taning t) {
    if (t.type == TaningType.countUp && t.startDate != null) {
      return 'Since ${_fmt(t.startDate!)}';
    }
    if (t.type == TaningType.duration) {
      final s = t.startDate != null ? _fmt(t.startDate!) : '';
      final e = t.endDate != null ? _fmt(t.endDate!) : '';
      return '$s → $e';
    }
    if (t.endDate != null) return _fmt(t.endDate!);
    return 'Not set';
  }

  String _notifLabel(NotificationSettings s) {
    if (!s.enabled) return 'Off';
    final r = <String>[];
    if (s.oneDayBefore) r.add('1d');
    if (s.oneHourBefore) r.add('1h');
    if (s.thirtyMinutesBefore) r.add('30m');
    if (s.atExactTime) r.add('Exact');
    return r.isEmpty ? 'On' : r.join(', ');
  }

  String _fmt(DateTime d) => DateFormat('MMM d, y • h:mm a').format(d);
}