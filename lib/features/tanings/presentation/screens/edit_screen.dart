import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:taning/core/services/logger.dart';
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
  late TextEditingController _titleCtrl;
  late TextEditingController _descCtrl;

  late TaningType _type;
  late RecurrencePattern? _recurrence;
  late DateTime? _startDate;
  late DateTime? _endDate;
  late TaningIcon _icon;
  late TaningColor _color;
  late CountdownStyle _style;
  late NotificationSettings _notifs;

  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final t = widget.taning;
    _titleCtrl = TextEditingController(text: t.title);
    _descCtrl = TextEditingController(text: t.description ?? '');
    _type = t.type;
    _recurrence = t.recurrence;
    _startDate = t.startDate;
    _endDate = t.endDate;
    _icon = t.icon;
    _color = t.color;
    _style = t.countdownStyle;
    _notifs = t.notificationSettings;
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
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
            onPressed: _saving ? null : _save,
            child: Text(
              _saving ? 'Saving...' : 'Save',
              style: TextStyle(color: accentColor),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.fromLTRB(
            24,
            24,
            24,
            24 + MediaQuery.of(context).viewInsets.bottom,
          ),
          children: [
            // Title
            TextFormField(
              controller: _titleCtrl,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Please enter a title'
                  : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _descCtrl,
              decoration: const InputDecoration(
                labelText: 'Description (optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 24),

            // Type
            _sectionTitle('Type'),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: TaningType.values.map((type) {
                final sel = _type == type;
                return FilterChip(
                  label: Text(_typeLabel(type)),
                  selected: sel,
                  onSelected: (_) => setState(() {
                    _type = type;
                    if (type != TaningType.recurring) {
                      _recurrence = null;
                    }
                  }),
                  selectedColor: accentColor.withValues(alpha: 0.2),
                  backgroundColor:
                      isDark ? Colors.grey.shade800 : Colors.grey.shade100,
                  labelStyle: TextStyle(
                    color: sel
                        ? accentColor
                        : (isDark ? Colors.grey.shade300 : Colors.grey.shade700),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Date(s)
            _sectionTitle(_dateSectionTitle()),
            _datePicker(
              label: _dateLabelFor(),
              date: _type == TaningType.countUp ? _startDate : _endDate,
              accentColor: accentColor,
              onPick: () async {
                final picked = await _pickDateTime(
                  _type == TaningType.countUp ? _startDate : _endDate,
                );
                if (picked != null) {
                  setState(() {
                    if (_type == TaningType.countUp) {
                      _startDate = picked;
                    } else {
                      _endDate = picked;
                    }
                  });
                }
              },
            ),
            if (_type == TaningType.duration) ...[
              const SizedBox(height: 8),
              _datePicker(
                label: 'End',
                date: _endDate,
                accentColor: accentColor,
                onPick: () async {
                  final picked = await _pickDateTime(_endDate);
                  if (picked != null) setState(() => _endDate = picked);
                },
              ),
            ],
            const SizedBox(height: 24),

            // Icon
            _sectionTitle('Icon'),
            _editIconPicker(accentColor, isDark),
            const SizedBox(height: 24),

            // Color
            _sectionTitle('Color'),
            _editColorPicker(accentColor),
            const SizedBox(height: 24),

            // Style
            _sectionTitle('Countdown Style'),
            _editStylePicker(accentColor, isDark),
            const SizedBox(height: 32),

            // Save
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _saving ? null : _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _saving
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text('Save Changes'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String t) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          t,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      );

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

  String _dateSectionTitle() {
    switch (_type) {
      case TaningType.countUp:
        return 'Start Date';
      case TaningType.duration:
        return 'Start & End';
      default:
        return 'Target Date';
    }
  }

  String _dateLabelFor() {
    switch (_type) {
      case TaningType.countUp:
        return 'Start';
      case TaningType.recurring:
        return 'Next occurrence';
      default:
        return 'Target';
    }
  }

  Widget _datePicker({
    required String label,
    required DateTime? date,
    required Color accentColor,
    required VoidCallback onPick,
  }) {
    final fmt = date != null
        ? DateFormat('EEE, MMM d, y • h:mm a').format(date)
        : 'Not set';
    return Card(
      child: ListTile(
        leading:
            Icon(Icons.event, color: date != null ? accentColor : Colors.grey),
        title: Text(label,
            style: const TextStyle(fontSize: 12, color: Colors.grey)),
        subtitle: Text(
          fmt,
          style: TextStyle(
            fontSize: 14,
            fontWeight: date != null ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
        trailing: date != null
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () => setState(() {
                  if (_type == TaningType.countUp) {
                    _startDate = null;
                  } else {
                    _endDate = null;
                  }
                }),
              )
            : null,
        onTap: onPick,
      ),
    );
  }

  Widget _editIconPicker(Color accentColor, bool isDark) {
    final presets = [
      const TaningIcon(codePoint: 0xE8ED, family: 'MaterialIcons'),
      const TaningIcon(codePoint: 0xE8F0, family: 'MaterialIcons'),
      const TaningIcon(codePoint: 0xE8F5, family: 'MaterialIcons'),
      const TaningIcon(codePoint: 0xE8F8, family: 'MaterialIcons'),
      const TaningIcon(codePoint: 0xE8FB, family: 'MaterialIcons'),
      const TaningIcon(codePoint: 0xE8FE, family: 'MaterialIcons'),
      const TaningIcon(codePoint: 0xE8E9, family: 'MaterialIcons'),
      const TaningIcon(codePoint: 0xE8FD, family: 'MaterialIcons'),
      const TaningIcon(codePoint: 0xE8F1, family: 'MaterialIcons'),
      const TaningIcon(codePoint: 0xE8F2, family: 'MaterialIcons'),
      const TaningIcon(codePoint: 0xE8F3, family: 'MaterialIcons'),
      const TaningIcon(codePoint: 0xE8F4, family: 'MaterialIcons'),
      const TaningIcon(codePoint: 0xE8F6, family: 'MaterialIcons'),
      const TaningIcon(codePoint: 0xE8F7, family: 'MaterialIcons'),
      const TaningIcon(codePoint: 0xE8F9, family: 'MaterialIcons'),
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        // Upload tile
        GestureDetector(
          onTap: _pickIconImage,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _icon.imagePath != null
                  ? accentColor.withValues(alpha: 0.15)
                  : (isDark ? Colors.grey.shade800 : Colors.grey.shade100),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _icon.imagePath != null
                    ? accentColor
                    : (isDark ? Colors.grey.shade700 : Colors.grey.shade300),
                width: _icon.imagePath != null ? 2 : 1,
              ),
            ),
            child: SizedBox(
              width: 24,
              height: 24,
              child: _icon.imagePath != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.file(File(_icon.imagePath!),
                          fit: BoxFit.cover),
                    )
                  : Icon(
                      Icons.add_photo_alternate_outlined,
                      color: isDark
                          ? Colors.grey.shade400
                          : Colors.grey.shade700,
                    ),
            ),
          ),
        ),
        // Presets
        ...presets.map((icon) {
          final sel = _icon.imagePath == null &&
              icon.codePoint == _icon.codePoint;
          return GestureDetector(
            onTap: () => setState(() => _icon = icon),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: sel
                    ? accentColor.withValues(alpha: 0.15)
                    : (isDark ? Colors.grey.shade800 : Colors.grey.shade100),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: sel
                      ? accentColor
                      : (isDark ? Colors.grey.shade700 : Colors.grey.shade300),
                  width: sel ? 2 : 1,
                ),
              ),
              child: Text(
                String.fromCharCode(icon.codePoint),
                style: TextStyle(
                  fontFamily: 'MaterialIcons',
                  fontSize: 24,
                  color: sel
                      ? accentColor
                      : (isDark
                          ? Colors.grey.shade400
                          : Colors.grey.shade700),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _editColorPicker(Color accentColor) {
    const presets = [
      TaningColor(value: 0xFF4F46E5),
      TaningColor(value: 0xFF7C3AED),
      TaningColor(value: 0xFFEC4899),
      TaningColor(value: 0xFFEF4444),
      TaningColor(value: 0xFFF97316),
      TaningColor(value: 0xFFFCD34D),
      TaningColor(value: 0xFF22C55E),
      TaningColor(value: 0xFF14B8A6),
      TaningColor(value: 0xFF0EA5E9),
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: presets.map((c) {
        final sel = c.value == _color.value;
        final cv = Color(c.value);
        return GestureDetector(
          onTap: () => setState(() => _color = c),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: cv,
              shape: BoxShape.circle,
              border: Border.all(
                color: sel ? cv : Colors.grey.shade400,
                width: sel ? 3 : 1,
              ),
            ),
            child: sel
                ? Icon(
                    Icons.check,
                    color: cv.computeLuminance() > 0.5
                        ? Colors.black
                        : Colors.white,
                    size: 20,
                  )
                : null,
          ),
        );
      }).toList(),
    );
  }

  Widget _editStylePicker(Color accentColor, bool isDark) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        FilterChip(
          label: const Text('Simple'),
          selected: _style == CountdownStyle.simple,
          onSelected: (_) =>
              setState(() => _style = CountdownStyle.simple),
          selectedColor: accentColor.withValues(alpha: 0.2),
          backgroundColor:
              isDark ? Colors.grey.shade800 : Colors.grey.shade100,
          avatar: Text('14d 6h 42m',
              style: TextStyle(
                  fontSize: 10,
                  color: isDark ? Colors.grey.shade500 : Colors.grey.shade600)),
        ),
        FilterChip(
          label: const Text('Detailed'),
          selected: _style == CountdownStyle.detailed,
          onSelected: (_) =>
              setState(() => _style = CountdownStyle.detailed),
          selectedColor: accentColor.withValues(alpha: 0.2),
          backgroundColor:
              isDark ? Colors.grey.shade800 : Colors.grey.shade100,
          avatar: Text('…12s',
              style: TextStyle(
                  fontSize: 10,
                  color: isDark ? Colors.grey.shade500 : Colors.grey.shade600)),
        ),
      ],
    );
  }

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
          : const TimeOfDay(hour: 0, minute: 0),
    );
    if (time == null) return null;
    return DateTime(
        date.year, date.month, date.day, time.hour, time.minute);
  }

  Future<void> _pickIconImage() async {
    try {
      final picked = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 256,
        maxHeight: 256,
        imageQuality: 85,
      );
      if (picked == null) return;
      final docs = await getApplicationDocumentsDirectory();
      final dir = Directory('${docs.path}/user_icons');
      if (!await dir.exists()) await dir.create(recursive: true);
      final ext = picked.path.split('.').last;
      final dest =
          '${dir.path}/icon_${DateTime.now().millisecondsSinceEpoch}.$ext';
      await File(picked.path).copy(dest);
      setState(() {
        _icon = TaningIcon(
          codePoint: _icon.codePoint,
          family: _icon.family,
          imagePath: dest,
        );
      });
    } catch (_) {}
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      final updated = widget.taning.copyWith(
        title: _titleCtrl.text.trim(),
        description: _descCtrl.text.trim().isEmpty
            ? null
            : _descCtrl.text.trim(),
        type: _type,
        startDate: _startDate,
        endDate: _endDate,
        icon: _icon,
        color: _color,
        countdownStyle: _style,
        notificationSettings: _notifs,
        recurrence: _recurrence,
        updatedAt: DateTime.now(),
      );
      await ref.read(taningRepositoryProvider).save(updated);
      if (mounted) {
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${updated.title} updated!'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      LoggerService.error('Edit failed: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Update failed: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}