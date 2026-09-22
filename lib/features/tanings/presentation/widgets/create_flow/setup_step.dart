import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taning/features/settings/presentation/providers/settings_providers.dart';
import 'package:taning/features/tanings/domain/entities/taning.dart';
import 'package:taning/features/tanings/presentation/view_models/create_view_model.dart';

class SetupStep extends ConsumerStatefulWidget {
  final CreateViewModel viewModel;
  final VoidCallback onNext;

  const SetupStep({
    super.key,
    required this.viewModel,
    required this.onNext,
  });

  @override
  ConsumerState<SetupStep> createState() => _SetupStepState();
}

class _SetupStepState extends ConsumerState<SetupStep> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _titleFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.viewModel.title;
    _descriptionController.text = widget.viewModel.description ?? '';
    _titleFocus.requestFocus();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _titleFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = ref.watch(accentColorProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
          const Text(
            "What's your Taning?",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          const Text(
            'Give it a name and pick how it counts time',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 24),

          // ── Title ──
          TextField(
            controller: _titleController,
            focusNode: _titleFocus,
            decoration: const InputDecoration(
              labelText: 'Title',
              hintText: 'e.g., Vacation, Exam, Birthday',
              border: OutlineInputBorder(),
            ),
            onChanged: (v) {
              widget.viewModel.title = v;
              setState(() {});
            },
            textInputAction: TextInputAction.next,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: 'Description (optional)',
              hintText: 'Any details worth remembering',
              border: OutlineInputBorder(),
            ),
            onChanged: (v) => widget.viewModel.description = v,
            maxLines: 2,
            textInputAction: TextInputAction.done,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(height: 32),

          // ── Type ──
          const Text(
            'How does it count?',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          ...TaningType.values.map((type) {
            final isSelected = widget.viewModel.type == type;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _TypeCard(
                type: type,
                isSelected: isSelected,
                accentColor: accentColor,
                isDark: isDark,
                onTap: () {
                  setState(() {
                    widget.viewModel.type = type;
                    if (type != TaningType.recurring) {
                      widget.viewModel.recurrencePattern = null;
                    }
                  });
                },
              ),
            );
          }),

          // ── Recurrence (inline, only when Recurring) ──
          if (widget.viewModel.type == TaningType.recurring)
            _buildRecurrencePanel(accentColor, isDark),

          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed:
                  widget.viewModel.canProceedToStep2 ? widget.onNext : null,
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
    );
  }

  Widget _buildRecurrencePanel(Color accentColor, bool isDark) {
    final pattern = widget.viewModel.recurrencePattern;

    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade900 : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Repeats',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _RecurrenceChip(
                label: 'Daily',
                isSelected: pattern is DailyRecurrence,
                accentColor: accentColor,
                onTap: () {
                  widget.viewModel.setDailyRecurrence();
                  setState(() {});
                },
              ),
              _RecurrenceChip(
                label: 'Weekly',
                isSelected: pattern is WeeklyRecurrence,
                accentColor: accentColor,
                onTap: () {
                  widget.viewModel
                      .setWeeklyRecurrence(weekdays: [DateTime.monday]);
                  setState(() {});
                },
              ),
              _RecurrenceChip(
                label: 'Monthly',
                isSelected: pattern is MonthlyRecurrence,
                accentColor: accentColor,
                onTap: () {
                  widget.viewModel.setMonthlyRecurrence(dayOfMonth: 1);
                  setState(() {});
                },
              ),
              _RecurrenceChip(
                label: 'Yearly',
                isSelected: pattern is YearlyRecurrence,
                accentColor: accentColor,
                onTap: () {
                  widget.viewModel
                      .setYearlyRecurrence(month: DateTime.now().month);
                  setState(() {});
                },
              ),
            ],
          ),
          if (pattern is WeeklyRecurrence) ...[
            const SizedBox(height: 12),
            _buildWeekdayPicker(pattern, accentColor),
          ],
        ],
      ),
    );
  }

  Widget _buildWeekdayPicker(
    WeeklyRecurrence pattern,
    Color accentColor,
  ) {
    const labels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return Wrap(
      spacing: 6,
      children: List.generate(7, (i) {
        final dayValue = i + 1;
        final isSelected = pattern.weekdays.contains(dayValue);
        return ChoiceChip(
          label: Text(labels[i]),
          selected: isSelected,
          onSelected: (sel) {
            final next = List<int>.from(pattern.weekdays);
            if (sel) {
              next.add(dayValue);
            } else {
              next.remove(dayValue);
            }
            widget.viewModel.setWeeklyRecurrence(
              weekdays: next.isEmpty ? [1] : next,
            );
            setState(() {});
          },
          selectedColor: accentColor.withValues(alpha: 0.2),
        );
      }),
    );
  }
}

class _TypeCard extends StatelessWidget {
  final TaningType type;
  final bool isSelected;
  final Color accentColor;
  final bool isDark;
  final VoidCallback onTap;

  const _TypeCard({
    required this.type,
    required this.isSelected,
    required this.accentColor,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final (icon, title, desc) = _info(type);
    return Card(
      elevation: isSelected ? 2 : 0,
      color: isDark ? Colors.grey.shade900 : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? accentColor : Colors.transparent,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Icon(
                icon,
                color: isSelected ? accentColor : Colors.grey,
                size: 26,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? accentColor : null,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      desc,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Icon(Icons.check_circle, color: accentColor, size: 22),
            ],
          ),
        ),
      ),
    );
  }

  (IconData, String, String) _info(TaningType type) {
    switch (type) {
      case TaningType.countdown:
        return (
          Icons.timer_outlined,
          'Countdown',
          'Count down to a specific date',
        );
      case TaningType.duration:
        return (
          Icons.speed_outlined,
          'Duration',
          'Track progress over a fixed period',
        );
      case TaningType.countUp:
        return (
          Icons.trending_up_outlined,
          'Count Up',
          'Count time since a starting date',
        );
      case TaningType.recurring:
        return (
          Icons.repeat_outlined,
          'Recurring',
          'Events that repeat regularly',
        );
    }
  }
}

class _RecurrenceChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Color accentColor;
  final VoidCallback onTap;

  const _RecurrenceChip({
    required this.label,
    required this.isSelected,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onTap(),
      selectedColor: accentColor.withValues(alpha: 0.2),
    );
  }
}