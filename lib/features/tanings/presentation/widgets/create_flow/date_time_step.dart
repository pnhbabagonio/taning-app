import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:taning/features/settings/presentation/providers/settings_providers.dart';
import 'package:taning/features/tanings/domain/entities/taning.dart';
import 'package:taning/features/tanings/presentation/view_models/create_view_model.dart';

class DateTimeStep extends ConsumerStatefulWidget {
  final CreateViewModel viewModel;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const DateTimeStep({
    super.key,
    required this.viewModel,
    required this.onNext,
    required this.onBack,
  });

  @override
  ConsumerState<DateTimeStep> createState() => _DateTimeStepState();
}

class _DateTimeStepState extends ConsumerState<DateTimeStep> {
  @override
  Widget build(BuildContext context) {
    final accentColor = ref.watch(accentColorProvider);
    final type = widget.viewModel.type;

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        24,
        24,
        24,
        24 + MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            _titleFor(type),
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            _subtitleFor(type),
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 32),

          // For Duration: two pickers
          if (type == TaningType.duration) ...[
            _buildDatePicker(
              label: 'Start',
              date: widget.viewModel.startDate,
              accentColor: accentColor,
              onPick: _pickStartDate,
              onClear: () => setState(() => widget.viewModel.startDate = null),
            ),
            const SizedBox(height: 12),
            _buildDatePicker(
              label: 'End',
              date: widget.viewModel.endDate,
              accentColor: accentColor,
              onPick: _pickEndDate,
              onClear: () => setState(() => widget.viewModel.endDate = null),
            ),
          ] else ...[
            // For Countdown / CountUp / Recurring: one picker
            _buildDatePicker(
              label: _singleLabel(type),
              date: type == TaningType.countUp
                  ? widget.viewModel.startDate
                  : widget.viewModel.endDate,
              accentColor: accentColor,
              onPick: type == TaningType.countUp
                  ? _pickStartDate
                  : _pickEndDate,
              onClear: () => setState(() {
                if (type == TaningType.countUp) {
                  widget.viewModel.startDate = null;
                } else {
                  widget.viewModel.endDate = null;
                }
              }),
            ),
          ],

          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: widget.onBack,
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
                  onPressed:
                      widget.viewModel.isDateValid ? widget.onNext : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey.shade300,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Next'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDatePicker({
    required String label,
    required DateTime? date,
    required Color accentColor,
    required Future<void> Function() onPick,
    required VoidCallback onClear,
  }) {
    final formatted = date != null
        ? DateFormat('EEEE, MMM d, y • h:mm a').format(date)
        : 'Not set';

    return Card(
      child: ListTile(
        leading: Icon(
          Icons.event,
          color: date != null ? accentColor : Colors.grey,
        ),
        title: Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        subtitle: Text(
          formatted,
          style: TextStyle(
            fontSize: 14,
            fontWeight: date != null ? FontWeight.w500 : FontWeight.normal,
            color: date != null ? null : Colors.grey,
          ),
        ),
        trailing: date != null
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: onClear,
              )
            : null,
        onTap: onPick,
      ),
    );
  }

  String _titleFor(TaningType type) {
    switch (type) {
      case TaningType.countdown:
        return 'When does it end?';
      case TaningType.duration:
        return 'When does it start and end?';
      case TaningType.countUp:
        return 'When did it start?';
      case TaningType.recurring:
        return 'When does it happen?';
    }
  }

  String _subtitleFor(TaningType type) {
    switch (type) {
      case TaningType.countdown:
        return 'Pick the date and time you are counting down to';
      case TaningType.duration:
        return 'Pick the start and end of your period';
      case TaningType.countUp:
        return 'Pick the date and time you want to count from';
      case TaningType.recurring:
        return 'Pick the next occurrence';
    }
  }

  String _singleLabel(TaningType type) {
    switch (type) {
      case TaningType.countUp:
        return 'Start';
      case TaningType.recurring:
        return 'Next occurrence';
      default:
        return 'Target';
    }
  }

  Future<void> _pickStartDate() async {
    final picked = await _pickDateTime(widget.viewModel.startDate);
    if (picked != null) {
      setState(() => widget.viewModel.startDate = picked);
    }
  }

  Future<void> _pickEndDate() async {
    final picked = await _pickDateTime(widget.viewModel.endDate);
    if (picked != null) {
      setState(() => widget.viewModel.endDate = picked);
    }
  }

  /// Shows date picker, then time picker. Defaults to today at 12:00 AM.
  Future<DateTime?> _pickDateTime(DateTime? initial) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final date = await showDatePicker(
      context: context,
      initialDate: initial ?? today,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 20),
    );
    if (date == null) return null;

    if (!mounted) return null;

    final time = await showTimePicker(
      context: context,
      initialTime: initial != null
          ? TimeOfDay.fromDateTime(initial)
          : const TimeOfDay(hour: 0, minute: 0), // 12:00 AM
    );
    if (time == null) return null;

    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }
}