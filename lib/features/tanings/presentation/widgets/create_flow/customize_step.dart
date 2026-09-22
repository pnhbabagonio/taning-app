// ignore_for_file: non_const_argument_for_const_parameter

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:taning/features/settings/presentation/providers/settings_providers.dart';
import 'package:taning/features/tanings/domain/entities/taning.dart';
import 'package:taning/features/tanings/presentation/view_models/create_view_model.dart';

class CustomizeStep extends ConsumerStatefulWidget {
  final CreateViewModel viewModel;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const CustomizeStep({
    super.key,
    required this.viewModel,
    required this.onNext,
    required this.onBack,
  });

  @override
  ConsumerState<CustomizeStep> createState() => _CustomizeStepState();
}

class _CustomizeStepState extends ConsumerState<CustomizeStep> {
  @override
  Widget build(BuildContext context) {
    final accentColor = ref.watch(accentColorProvider);
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            'Customize',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          const Text(
            'Make it yours',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 16 + keyboardHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon
                  const Text(
                    'Icon',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  _IconPicker(
                    selected: widget.viewModel.selectedIcon,
                    onChanged: (icon) {
                      setState(() => widget.viewModel.selectedIcon = icon);
                    },
                  ),
                  const SizedBox(height: 24),

                  // Color
                  const Text(
                    'Color',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  _ColorPicker(
                    selected: widget.viewModel.selectedColor,
                    onChanged: (c) {
                      setState(() => widget.viewModel.selectedColor = c);
                    },
                  ),
                  const SizedBox(height: 24),

                  // Countdown style
                  const Text(
                    'Countdown Style',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  _StylePicker(
                    selected: widget.viewModel.selectedStyle,
                    onChanged: (s) {
                      setState(() => widget.viewModel.selectedStyle = s);
                    },
                  ),
                  const SizedBox(height: 24),

                  // Notifications
                  const Text(
                    'Notifications',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  _NotificationEditor(
                    settings: widget.viewModel.notificationSettings,
                    onChanged: (s) {
                      setState(
                          () => widget.viewModel.notificationSettings = s);
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: bottomPadding + 8),
            child: Row(
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
                    onPressed: widget.onNext,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Preview'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Icon Picker ──

class _IconPicker extends ConsumerStatefulWidget {
  final TaningIcon selected;
  final ValueChanged<TaningIcon> onChanged;

  const _IconPicker({required this.selected, required this.onChanged});

  @override
  ConsumerState<_IconPicker> createState() => _IconPickerState();
}

class _IconPickerState extends ConsumerState<_IconPicker> {
  bool _isUploading = false;

  static const List<TaningIcon> _presets = [
    TaningIcon(codePoint: 0xE8ED, family: 'MaterialIcons'), // flight
    TaningIcon(codePoint: 0xE8F0, family: 'MaterialIcons'), // cake
    TaningIcon(codePoint: 0xE8F5, family: 'MaterialIcons'), // school
    TaningIcon(codePoint: 0xE8F8, family: 'MaterialIcons'), // assignment
    TaningIcon(codePoint: 0xE8FB, family: 'MaterialIcons'), // fitness
    TaningIcon(codePoint: 0xE8FE, family: 'MaterialIcons'), // favorite
    TaningIcon(codePoint: 0xE8E9, family: 'MaterialIcons'), // event_note
    TaningIcon(codePoint: 0xE8FD, family: 'MaterialIcons'), // star
    TaningIcon(codePoint: 0xE8F1, family: 'MaterialIcons'), // celebration
    TaningIcon(codePoint: 0xE8F2, family: 'MaterialIcons'), // event
    TaningIcon(codePoint: 0xE8F3, family: 'MaterialIcons'), // calendar
    TaningIcon(codePoint: 0xE8F4, family: 'MaterialIcons'), // schedule
    TaningIcon(codePoint: 0xE8F6, family: 'MaterialIcons'), // school
    TaningIcon(codePoint: 0xE8F7, family: 'MaterialIcons'), // work
    TaningIcon(codePoint: 0xE8F9, family: 'MaterialIcons'), // events
  ];

  @override
  Widget build(BuildContext context) {
    final accentColor = ref.watch(accentColorProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        // Upload button (first tile)
        GestureDetector(
          onTap: _isUploading ? null : _pickImage,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: widget.selected.imagePath != null
                  ? accentColor.withValues(alpha: 0.15)
                  : (isDark ? Colors.grey.shade800 : Colors.grey.shade100),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: widget.selected.imagePath != null
                    ? accentColor
                    : (isDark ? Colors.grey.shade700 : Colors.grey.shade300),
                width: widget.selected.imagePath != null ? 2 : 1,
              ),
            ),
            child: SizedBox(
              width: 24,
              height: 24,
              child: widget.selected.imagePath != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.file(
                        File(widget.selected.imagePath!),
                        fit: BoxFit.cover,
                      ),
                    )
                  : Icon(
                      _isUploading ? Icons.hourglass_empty : Icons.add_photo_alternate_outlined,
                      size: 22,
                      color: isDark
                          ? Colors.grey.shade400
                          : Colors.grey.shade700,
                    ),
            ),
          ),
        ),

        // Preset icons
        ..._presets.map((icon) {
          final isSelected = widget.selected.imagePath == null &&
              icon.codePoint == widget.selected.codePoint;
          return GestureDetector(
            onTap: () => widget.onChanged(icon),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected
                    ? accentColor.withValues(alpha: 0.15)
                    : (isDark ? Colors.grey.shade800 : Colors.grey.shade100),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isSelected
                      ? accentColor
                      : (isDark ? Colors.grey.shade700 : Colors.grey.shade300),
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
        }),
      ],
    );
  }

  Future<void> _pickImage() async {
    setState(() => _isUploading = true);
    try {
      final picked = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 256,
        maxHeight: 256,
        imageQuality: 85,
      );
      if (picked == null) return;

      final docs = await getApplicationDocumentsDirectory();
      final iconsDir = Directory('${docs.path}/user_icons');
      if (!await iconsDir.exists()) {
        await iconsDir.create(recursive: true);
      }
      final ext = picked.path.split('.').last;
      final dest =
          '${iconsDir.path}/icon_${DateTime.now().millisecondsSinceEpoch}.$ext';
      await File(picked.path).copy(dest);

      widget.onChanged(TaningIcon(
        codePoint: widget.selected.codePoint,
        family: widget.selected.family,
        imagePath: dest,
      ));
    } catch (_) {
      // Silent — user cancelled or error
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }
}

// ── Color Picker ──

class _ColorPicker extends ConsumerWidget {
  final TaningColor selected;
  final ValueChanged<TaningColor> onChanged;

  const _ColorPicker({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 9 presets (no duplicate gold/amber)
    const presets = [
      TaningColor(value: 0xFF4F46E5), // Indigo
      TaningColor(value: 0xFF7C3AED), // Purple
      TaningColor(value: 0xFFEC4899), // Pink
      TaningColor(value: 0xFFEF4444), // Red
      TaningColor(value: 0xFFF97316), // Orange
      TaningColor(value: 0xFFFCD34D), // Gold
      TaningColor(value: 0xFF22C55E), // Green
      TaningColor(value: 0xFF14B8A6), // Teal
      TaningColor(value: 0xFF0EA5E9), // Sky
    ];

    final isCustom = !presets.any((p) => p.value == selected.value);

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        ...presets.map((color) {
          final isSelected = color.value == selected.value;
          final c = Color(color.value);
          return GestureDetector(
            onTap: () => onChanged(color),
            child: Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: c,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? c : Colors.grey.shade400,
                  width: isSelected ? 3 : 1,
                ),
              ),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      color: c.computeLuminance() > 0.5
                          ? Colors.black
                          : Colors.white,
                      size: 22,
                    )
                  : null,
            ),
          );
        }),

        // 10th: Custom color wheel
        GestureDetector(
          onTap: () => _openWheel(context, ref),
          child: Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const SweepGradient(
                colors: [
                  Colors.red,
                  Colors.yellow,
                  Colors.green,
                  Colors.cyan,
                  Colors.blue,
                  Colors.purple,
                  Colors.red,
                ],
              ),
              border: Border.all(
                color: isCustom ? Colors.white : Colors.grey.shade400,
                width: isCustom ? 3 : 1,
              ),
            ),
            child: isCustom
                ? const Icon(Icons.check, color: Colors.white, size: 20)
                : const Icon(Icons.colorize, color: Colors.white, size: 18),
          ),
        ),
      ],
    );
  }

  Future<void> _openWheel(BuildContext context, WidgetRef ref) async {
    final initial = Color(selected.value);
    final picked = await showDialog<Color>(
      context: context,
      builder: (ctx) => _ColorWheelDialog(initial: initial),
    );
    if (picked != null) {
      onChanged(TaningColor(value: picked.toARGB32()));
    }
  }
}

class _ColorWheelDialog extends StatefulWidget {
  final Color initial;
  const _ColorWheelDialog({required this.initial});

  @override
  State<_ColorWheelDialog> createState() => _ColorWheelDialogState();
}

class _ColorWheelDialogState extends State<_ColorWheelDialog> {
  late double _hue;
  late double _sat;
  late double _light;

  @override
  void initState() {
    super.initState();
    final hsl = HSLColor.fromColor(widget.initial);
    _hue = hsl.hue;
    _sat = hsl.saturation;
    _light = hsl.lightness;
  }

  Color get _color =>
      HSLColor.fromAHSL(1.0, _hue, _sat, _light).toColor();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: const Text('Custom Color'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: _color,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade300),
            ),
          ),
          const SizedBox(height: 16),
          _slider('Hue', _hue, 0, 360, (v) => setState(() => _hue = v)),
          _slider('Saturation', _sat, 0, 1, (v) => setState(() => _sat = v)),
          _slider('Lightness', _light, 0.1, 0.9, (v) => setState(() => _light = v)),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, _color),
          child: const Text('Use'),
        ),
      ],
    );
  }

  Widget _slider(
    String label,
    double value,
    double min,
    double max,
    ValueChanged<double> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12)),
        Slider(
          value: value,
          min: min,
          max: max,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

// ── Style Picker ──

class _StylePicker extends ConsumerWidget {
  final CountdownStyle selected;
  final ValueChanged<CountdownStyle> onChanged;

  const _StylePicker({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accentColor = ref.watch(accentColorProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final options = [
      (
        CountdownStyle.simple,
        'Simple',
        '14d 6h 42m',
        'Updates every minute',
      ),
      (
        CountdownStyle.detailed,
        'Detailed',
        '14d 6h 42m 12s',
        'Live seconds',
      ),
    ];

    return Column(
      children: options.map((opt) {
        final (style, label, example, hint) = opt;
        final isSelected = selected == style;
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Card(
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
              onTap: () => onChanged(style),
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            label,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? accentColor : null,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            hint,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      example,
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? accentColor
                            : Colors.grey.shade600,
                      ),
                    ),
                    if (isSelected) ...[
                      const SizedBox(width: 8),
                      Icon(Icons.check_circle, color: accentColor, size: 20),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ── Notification Editor ──

class _NotificationEditor extends StatefulWidget {
  final NotificationSettings settings;
  final ValueChanged<NotificationSettings> onChanged;

  const _NotificationEditor({required this.settings, required this.onChanged});

  @override
  State<_NotificationEditor> createState() => _NotificationEditorState();
}

class _NotificationEditorState extends State<_NotificationEditor> {
  late NotificationSettings _s;

  @override
  void initState() {
    super.initState();
    _s = widget.settings;
  }

  void _update(NotificationSettings s) {
    setState(() => _s = s);
    widget.onChanged(s);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      color: isDark ? Colors.grey.shade900 : Colors.grey.shade50,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('Enable notifications'),
              value: _s.enabled,
              onChanged: (v) => _update(_s.copyWith(enabled: v)),
            ),
            if (_s.enabled) ...[
              const Divider(height: 1),
              _opt('1 day before', _s.oneDayBefore,
                  (v) => _update(_s.copyWith(oneDayBefore: v))),
              _opt('1 hour before', _s.oneHourBefore,
                  (v) => _update(_s.copyWith(oneHourBefore: v))),
              _opt('30 min before', _s.thirtyMinutesBefore,
                  (v) => _update(_s.copyWith(thirtyMinutesBefore: v))),
              _opt('At exact time', _s.atExactTime,
                  (v) => _update(_s.copyWith(atExactTime: v))),
            ],
          ],
        ),
      ),
    );
  }

  Widget _opt(String label, bool value, ValueChanged<bool> onChanged) {
    return CheckboxListTile(
      title: Text(label),
      value: value,
      onChanged: (v) => onChanged(v ?? false),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      dense: true,
    );
  }
}