import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taning/features/settings/presentation/providers/settings_providers.dart';
import 'package:taning/features/tanings/domain/entities/taning.dart';
import 'package:taning/features/tanings/presentation/providers/taning_providers.dart';

class EditScreen extends ConsumerStatefulWidget {
  final Taning taning;

  const EditScreen({super.key, required this.taning});

  @override
  ConsumerState<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends ConsumerState<EditScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form controllers
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  // Form state
  late DateTime? _selectedDate;
  late TimeOfDay? _selectedTime;
  late bool _isAllDay;
  late TaningType _selectedType;
  late TaningIcon _selectedIcon;
  late TaningColor _selectedColor;
  late TaningTheme _selectedTheme;
  late CountdownStyle _selectedStyle;
  late NotificationSettings _notificationSettings;
  late RecurrencePattern? _recurrencePattern;

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadTaningData();
  }

  void _loadTaningData() {
    final t = widget.taning;
    _titleController = TextEditingController(text: t.title);
    _descriptionController = TextEditingController(text: t.description ?? '');
    _selectedDate = t.endDate ?? t.startDate;
    _selectedTime =
        t.endDate != null ? TimeOfDay.fromDateTime(t.endDate!) : null;
    _isAllDay = t.isAllDay ?? false;
    _selectedType = t.type;
    _selectedIcon = t.icon;
    _selectedColor = t.color;
    _selectedTheme = t.theme;
    _selectedStyle = t.countdownStyle;
    _notificationSettings = t.notificationSettings;
    _recurrencePattern = t.recurrence;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = ref.watch(accentColorProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Taning'),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: _isSaving ? null : _saveChanges,
            child: Text(
              _isSaving ? 'Saving...' : 'Save',
              style: TextStyle(color: accentColor),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              const Text(
                'Title',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: 'e.g., Vacation, Exam, 30-Day Challenge',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(height: 16),

              // Description
              const Text(
                'Description (optional)',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  hintText: 'Add more details about your Taning',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(height: 24),

              // Date & Time
              const Text(
                'Date & Time',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.calendar_today),
                      title: Text(
                        _selectedDate != null
                            ? '${_formatDate(_selectedDate!)}${_selectedTime != null && !_isAllDay ? ' at ${_selectedTime!.format(context)}' : ''}'
                            : 'Select date',
                        style: TextStyle(
                          fontWeight: _selectedDate != null
                              ? FontWeight.w500
                              : FontWeight.normal,
                          color: _selectedDate != null ? null : Colors.grey,
                        ),
                      ),
                      trailing: _selectedDate != null
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  _selectedDate = null;
                                  _selectedTime = null;
                                });
                              },
                            )
                          : null,
                      onTap: _selectDate,
                    ),
                    if (_selectedDate != null && !_isAllDay) ...[
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.access_time),
                        title: Text(
                          _selectedTime != null
                              ? _selectedTime!.format(context)
                              : 'Select time',
                          style: TextStyle(
                            fontWeight: _selectedTime != null
                                ? FontWeight.w500
                                : FontWeight.normal,
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
                    ],
                    const Divider(height: 1),
                    SwitchListTile(
                      title: const Text('All day'),
                      subtitle:
                          const Text('Counts calendar days, not exact time'),
                      value: _isAllDay,
                      onChanged: (value) {
                        setState(() {
                          _isAllDay = value;
                          if (value) {
                            _selectedTime = null;
                          }
                        });
                      },
                      activeThumbColor: accentColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Type
              const Text(
                'Type',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: TaningType.values.map((type) {
                  final isSelected = _selectedType == type;
                  return FilterChip(
                    label: Text(_getTypeLabel(type)),
                    selected: isSelected,
                    onSelected: (_) {
                      setState(() {
                        _selectedType = type;
                      });
                    },
                    selectedColor: accentColor.withValues(alpha: 0.2),
                    backgroundColor:
                        isDark ? Colors.grey.shade800 : Colors.grey.shade100,
                    labelStyle: TextStyle(
                      color: isSelected
                          ? accentColor
                          : (isDark
                              ? Colors.grey.shade300
                              : Colors.grey.shade700),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // Icon
              const Text(
                'Icon',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _getIconOptions().map((icon) {
                  final isSelected = icon.codePoint == _selectedIcon.codePoint;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIcon = icon;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? accentColor.withValues(alpha: 0.15)
                            : isDark
                                ? Colors.grey.shade800
                                : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isSelected
                              ? accentColor
                              : (isDark
                                  ? Colors.grey.shade700
                                  : Colors.grey.shade300),
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Text(
                        String.fromCharCode(icon.codePoint),
                        style: TextStyle(
                          fontFamily: icon.family ?? 'MaterialIcons',
                          fontSize: 24,
                          color: isSelected
                              ? accentColor
                              : (isDark
                                  ? Colors.grey.shade400
                                  : Colors.grey.shade700),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // Color
              const Text(
                'Color',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: TaningColor.presets.map((color) {
                  final isSelected = color.value == _selectedColor.value;
                  final colorValue = Color(color.value);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedColor = color;
                      });
                    },
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: colorValue,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? colorValue
                              : (isDark
                                  ? Colors.grey.shade700
                                  : Colors.grey.shade400),
                          width: isSelected ? 3 : 1,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: colorValue.withValues(alpha: 0.4),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                ),
                              ]
                            : [],
                      ),
                      child: isSelected
                          ? Icon(
                              Icons.check,
                              color: colorValue.computeLuminance() > 0.5
                                  ? Colors.black
                                  : Colors.white,
                              size: 20,
                            )
                          : null,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // Countdown Style
              const Text(
                'Countdown Style',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _getStyleOptions().map((styleData) {
                  final isSelected = _selectedStyle == styleData['style'];
                  return FilterChip(
                    label: Text(styleData['label'] as String),
                    selected: isSelected,
                    onSelected: (_) {
                      setState(() {
                        _selectedStyle = styleData['style'] as CountdownStyle;
                      });
                    },
                    selectedColor: accentColor.withValues(alpha: 0.2),
                    backgroundColor:
                        isDark ? Colors.grey.shade800 : Colors.grey.shade100,
                    labelStyle: TextStyle(
                      color: isSelected
                          ? accentColor
                          : (isDark
                              ? Colors.grey.shade300
                              : Colors.grey.shade700),
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
                    avatar: Text(
                      styleData['example'] as String,
                      style: TextStyle(
                        fontSize: 10,
                        color: isDark
                            ? Colors.grey.shade500
                            : Colors.grey.shade600,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // Save Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _saveChanges,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isSaving
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Save Changes',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  List<TaningIcon> _getIconOptions() {
    return [
      const TaningIcon(codePoint: 0xE8ED, family: 'MaterialIcons'), // flight
      const TaningIcon(codePoint: 0xE8F0, family: 'MaterialIcons'), // cake
      const TaningIcon(codePoint: 0xE8F5, family: 'MaterialIcons'), // school
      const TaningIcon(
          codePoint: 0xE8F8, family: 'MaterialIcons'), // assignment
      const TaningIcon(
          codePoint: 0xE8FB, family: 'MaterialIcons'), // fitness_center
      const TaningIcon(codePoint: 0xE8FE, family: 'MaterialIcons'), // favorite
      const TaningIcon(
          codePoint: 0xE8E9, family: 'MaterialIcons'), // event_note
      const TaningIcon(codePoint: 0xE8FD, family: 'MaterialIcons'), // star
      const TaningIcon(codePoint: 0xE8EF, family: 'MaterialIcons'), // favorite
      const TaningIcon(
          codePoint: 0xE8F1, family: 'MaterialIcons'), // celebration
      const TaningIcon(codePoint: 0xE8F2, family: 'MaterialIcons'), // event
      const TaningIcon(
          codePoint: 0xE8F3, family: 'MaterialIcons'), // calendar_month
      const TaningIcon(codePoint: 0xE8F4, family: 'MaterialIcons'), // schedule
      const TaningIcon(codePoint: 0xE8F6, family: 'MaterialIcons'), // school
      const TaningIcon(codePoint: 0xE8F7, family: 'MaterialIcons'), // work
      const TaningIcon(
          codePoint: 0xE8F9, family: 'MaterialIcons'), // emoji_events
    ];
  }

  List<Map<String, dynamic>> _getStyleOptions() {
    return [
      {'style': CountdownStyle.simple, 'label': 'Simple', 'example': '14d'},
      {
        'style': CountdownStyle.detailed,
        'label': 'Detailed',
        'example': '14d 6h 42m'
      },
      {
        'style': CountdownStyle.full,
        'label': 'Full',
        'example': '14d 6h 42m 12s'
      },
      {
        'style': CountdownStyle.progress,
        'label': 'Progress',
        'example': 'Day 14/30'
      },
      {
        'style': CountdownStyle.calendar,
        'label': 'Calendar',
        'example': '14d • Aug 24'
      },
    ];
  }

  String _getTypeLabel(TaningType type) {
    switch (type) {
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

  String _formatDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }

  Future<void> _selectDate() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365 * 10)),
    );

    if (date != null) {
      setState(() {
        _selectedDate = date;
        if (_selectedTime != null) {
          _updateDateTime();
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
    // DateTime is stored in the Taning directly
    // No need to update separately
  }

  void _saveChanges() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      // Build the updated Taning
      final updatedTaning = widget.taning.copyWith(
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        type: _selectedType,
        startDate: widget.taning.startDate,
        endDate: _selectedDate,
        isAllDay: _isAllDay,
        icon: _selectedIcon,
        color: _selectedColor,
        theme: _selectedTheme,
        countdownStyle: _selectedStyle,
        notificationSettings: _notificationSettings,
        recurrence: _recurrencePattern,
        updatedAt: DateTime.now(),
        timezone: widget.taning.timezone ?? 'local',
      );

      await ref.read(taningRepositoryProvider).save(updatedTaning);

      if (mounted) {
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${updatedTaning.title} updated! ✏️'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      debugPrint('Error updating Taning: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Couldn\'t update this Taning: ${e.toString()}'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }
}
