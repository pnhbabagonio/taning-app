import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taning/features/tanings/presentation/view_models/create_view_model.dart';
import 'package:taning/features/settings/presentation/providers/settings_providers.dart';

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
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  bool _isAllDay = false;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.viewModel.endDate;
    _isAllDay = widget.viewModel.isAllDay;
    if (_selectedDate != null) {
      _selectedTime = TimeOfDay.fromDateTime(_selectedDate!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: EdgeInsets.fromLTRB(
        24,
        24,
        24,
        24 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            'When?',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Set the date and time for your Taning',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 32),
          // Date picker
          Card(
            child: ListTile(
              leading: const Icon(Icons.calendar_today),
              title: Text(
                _selectedDate != null
                    ? DateFormat('EEEE, MMMM d, y').format(_selectedDate!)
                    : 'Select date',
                style: TextStyle(
                  fontWeight: _selectedDate != null ? FontWeight.w500 : FontWeight.normal,
                  color: _selectedDate != null ? null : Colors.grey,
                ),
              ),
              trailing: _selectedDate != null
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _selectedDate = null;
                          widget.viewModel.endDate = null;
                        });
                      },
                    )
                  : null,
              onTap: _selectDate,
            ),
          ),
          const SizedBox(height: 12),
          // Time picker (only if not all-day)
          if (!_isAllDay)
            Card(
              child: ListTile(
                leading: const Icon(Icons.access_time),
                title: Text(
                  _selectedTime != null
                      ? _selectedTime!.format(context)
                      : 'Select time',
                  style: TextStyle(
                    fontWeight: _selectedTime != null ? FontWeight.w500 : FontWeight.normal,
                    color: _selectedTime != null ? null : Colors.grey,
                  ),
                ),
                trailing: _selectedTime != null
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _selectedTime = null;
                          });
                        },
                      )
                    : null,
                onTap: _selectTime,
              ),
            ),
          const SizedBox(height: 12),
          // All-day toggle
          SwitchListTile(
            title: const Text('All day'),
            subtitle: const Text('Counts calendar days, not exact time'),
            value: _isAllDay,
            onChanged: (value) {
              setState(() {
                _isAllDay = value;
                widget.viewModel.isAllDay = value;
                if (value) {
                  _selectedTime = null;
                }
              });
            },
          ),
          const SizedBox(height: 32),
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom + 8,
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: widget.onBack,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: ref.watch(accentColorProvider),
                      side: BorderSide(
                        color: ref.watch(accentColorProvider),
                      ),
                    ),
                    child: const Text('Back'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isDateValid ? widget.onNext : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ref.watch(accentColorProvider),
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      disabledBackgroundColor: Colors.grey.shade300,
                    ),
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

  bool get _isDateValid {
    if (_selectedDate == null) return false;
    if (!_isAllDay && _selectedTime == null) return false;
    return true;
  }

  Future<void> _selectDate() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365 * 10)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (date != null) {
      setState(() {
        _selectedDate = date;
        if (_selectedTime != null) {
          _updateDateTime();
        } else {
          widget.viewModel.endDate = date;
        }
      });
    }
  }

  Future<void> _selectTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );

    if (time != null) {
      setState(() {
        _selectedTime = time;
        _updateDateTime();
      });
    }
  }

  void _updateDateTime() {
    if (_selectedDate != null && _selectedTime != null) {
      widget.viewModel.endDate = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );
    }
  }
}
