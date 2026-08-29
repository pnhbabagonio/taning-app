import 'package:flutter/material.dart';
import 'package:taning/features/tanings/domain/entities/taning.dart';
import 'package:taning/features/tanings/presentation/view_models/create_view_model.dart';

class TypeStep extends StatefulWidget {
  final CreateViewModel viewModel;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const TypeStep({
    super.key,
    required this.viewModel,
    required this.onNext,
    required this.onBack,
  });

  @override
  State<TypeStep> createState() => _TypeStepState();
}

class _TypeStepState extends State<TypeStep> {
  TaningType _selectedType = TaningType.countdown;

  @override
  void initState() {
    super.initState();
    _selectedType = widget.viewModel.type;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            'What kind of Taning is this?',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Choose how you want to track time',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: ListView(
              children: [
                _TypeCard(
                  icon: Icons.timer_outlined,
                  title: 'Countdown',
                  description: 'Count down to a specific date or time',
                  isSelected: _selectedType == TaningType.countdown,
                  onTap: () => _selectType(TaningType.countdown),
                ),
                const SizedBox(height: 12),
                _TypeCard(
                  icon: Icons.speed_outlined,
                  title: 'Duration / Challenge',
                  description: 'Track progress through a fixed period',
                  isSelected: _selectedType == TaningType.duration,
                  onTap: () => _selectType(TaningType.duration),
                ),
                const SizedBox(height: 12),
                _TypeCard(
                  icon: Icons.trending_up_outlined,
                  title: 'Count Up',
                  description: 'Count time since a starting date',
                  isSelected: _selectedType == TaningType.countUp,
                  onTap: () => _selectType(TaningType.countUp),
                ),
                const SizedBox(height: 12),
                _TypeCard(
                  icon: Icons.repeat_outlined,
                  title: 'Recurring',
                  description: 'Events that repeat regularly',
                  isSelected: _selectedType == TaningType.recurring,
                  onTap: () => _selectType(TaningType.recurring),
                ),
                if (_selectedType == TaningType.recurring)
                  _buildRecurrenceOptions(),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom + 8,
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: widget.onBack,
                    child: const Text('Back'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _canProceed ? widget.onNext : null,
                    child: const Text('Next'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _selectType(TaningType type) {
    setState(() {
      _selectedType = type;
      widget.viewModel.type = type;
    });
  }

  bool get _canProceed {
    if (_selectedType == TaningType.recurring) {
      return widget.viewModel.recurrencePattern != null;
    }
    return true;
  }

  Widget _buildRecurrenceOptions() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recurrence Pattern',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _RecurrenceChip(
                label: 'Daily',
                isSelected:
                    widget.viewModel.recurrencePattern is DailyRecurrence,
                onTap: () {
                  widget.viewModel.setDailyRecurrence();
                  setState(() {});
                },
              ),
              _RecurrenceChip(
                label: 'Weekly',
                isSelected:
                    widget.viewModel.recurrencePattern is WeeklyRecurrence,
                onTap: () {
                  widget.viewModel.setWeeklyRecurrence(
                    weekdays: [DateTime.monday],
                  );
                  setState(() {});
                },
              ),
              _RecurrenceChip(
                label: 'Monthly',
                isSelected:
                    widget.viewModel.recurrencePattern is MonthlyRecurrence,
                onTap: () {
                  widget.viewModel.setMonthlyRecurrence(
                    dayOfMonth: 1,
                  );
                  setState(() {});
                },
              ),
              _RecurrenceChip(
                label: 'Yearly',
                isSelected:
                    widget.viewModel.recurrencePattern is YearlyRecurrence,
                onTap: () {
                  widget.viewModel.setYearlyRecurrence(
                    month: DateTime.now().month,
                  );
                  setState(() {});
                },
              ),
            ],
          ),
          if (widget.viewModel.recurrencePattern is WeeklyRecurrence)
            _buildWeeklyDaySelector(),
        ],
      ),
    );
  }

  Widget _buildWeeklyDaySelector() {
    final pattern = widget.viewModel.recurrencePattern as WeeklyRecurrence;
    final days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    final dayValues = [1, 2, 3, 4, 5, 6, 7];

    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: Wrap(
        spacing: 8,
        children: List.generate(7, (index) {
          final isSelected = pattern.weekdays.contains(dayValues[index]);
          return FilterChip(
            label: Text(days[index]),
            selected: isSelected,
            onSelected: (selected) {
              final newWeekdays = List<int>.from(pattern.weekdays);
              if (selected) {
                newWeekdays.add(dayValues[index]);
              } else {
                newWeekdays.remove(dayValues[index]);
              }
              widget.viewModel.setWeeklyRecurrence(
                weekdays: newWeekdays.isEmpty ? [1] : newWeekdays,
              );
              setState(() {});
            },
          );
        }),
      ),
    );
  }
}

class _TypeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  const _TypeCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isSelected ? 2 : 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color:
              isSelected ? Theme.of(context).primaryColor : Colors.transparent,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                icon,
                color:
                    isSelected ? Theme.of(context).primaryColor : Colors.grey,
                size: 28,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color:
                            isSelected ? Theme.of(context).primaryColor : null,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: Theme.of(context).primaryColor,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecurrenceChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _RecurrenceChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onTap(),
      selectedColor: Theme.of(context).primaryColor.withValues(alpha: 0.2),
    );
  }
}
