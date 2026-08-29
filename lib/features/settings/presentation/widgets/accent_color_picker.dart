import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taning/app/theme/app_colors.dart';
import 'package:taning/features/settings/presentation/providers/settings_providers.dart';

class AccentColorPicker extends ConsumerStatefulWidget {
  const AccentColorPicker({super.key});

  @override
  ConsumerState<AccentColorPicker> createState() => _AccentColorPickerState();
}

class _AccentColorPickerState extends ConsumerState<AccentColorPicker> {
  late Color _selectedColor;

  @override
  void initState() {
    super.initState();
    _selectedColor = ref.read(settingsProvider).accentColor;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: const Text('Select Accent Color'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: AppColors.presetColors.map((color) {
              final isSelected = color.toARGB32() == _selectedColor.toARGB32();
              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedColor = color;
                  });
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? Theme.of(context).primaryColor
                          : Colors.transparent,
                      width: 3,
                    ),
                  ),
                  child: isSelected
                      ? const Icon(Icons.check, color: Colors.white, size: 20)
                      : null,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          // Custom color picker
          InkWell(
            onTap: () async {
              final color = await showColorPicker(context);
              if (color != null) {
                setState(() {
                  _selectedColor = color;
                });
              }
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: _selectedColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade300, width: 2),
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            ref.read(settingsProvider.notifier).setAccentColor(_selectedColor);
            Navigator.pop(context);
          },
          child: const Text('Apply'),
        ),
      ],
    );
  }

  Future<Color?> showColorPicker(BuildContext context) async {
    return showDialog<Color>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text('Pick a Color'),
        content: SizedBox(
          width: 300,
          height: 300,
          child: ColorPicker(
            initialColor: _selectedColor,
            onColorChanged: (color) {
              setState(() {
                _selectedColor = color;
              });
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, _selectedColor),
            child: const Text('Select'),
          ),
        ],
      ),
    );
  }
}

// Simple Color Picker (if you don't want to add a package)
class ColorPicker extends StatefulWidget {
  final Color initialColor;
  final ValueChanged<Color> onColorChanged;

  const ColorPicker({
    super.key,
    required this.initialColor,
    required this.onColorChanged,
  });

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  late Color _selectedColor;

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.initialColor;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Hue slider
        const Text('Hue'),
        Slider(
          value: _selectedColor.hue,
          min: 0,
          max: 360,
          onChanged: (value) {
            setState(() {
              _selectedColor = HSLColor.fromAHSL(
                1,
                value,
                _selectedColor.saturation,
                _selectedColor.lightness,
              ).toColor();
            });
            widget.onColorChanged(_selectedColor);
          },
        ),
        // Saturation slider
        const Text('Saturation'),
        Slider(
          value: _selectedColor.saturation,
          min: 0,
          max: 1,
          onChanged: (value) {
            setState(() {
              _selectedColor = HSLColor.fromAHSL(
                1,
                _selectedColor.hue,
                value,
                _selectedColor.lightness,
              ).toColor();
            });
            widget.onColorChanged(_selectedColor);
          },
        ),
        // Lightness slider
        const Text('Lightness'),
        Slider(
          value: _selectedColor.lightness,
          min: 0,
          max: 1,
          onChanged: (value) {
            setState(() {
              _selectedColor = HSLColor.fromAHSL(
                1,
                _selectedColor.hue,
                _selectedColor.saturation,
                value,
              ).toColor();
            });
            widget.onColorChanged(_selectedColor);
          },
        ),
        const SizedBox(height: 16),
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: _selectedColor,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade300),
          ),
        ),
        Text(
          '#${_selectedColor.toARGB32().toRadixString(16).padLeft(8, '0')}',
          style: const TextStyle(fontFamily: 'monospace'),
        ),
      ],
    );
  }
}

extension ColorExtensions on Color {
  double get hue => HSLColor.fromColor(this).hue;
  double get saturation => HSLColor.fromColor(this).saturation;
  double get lightness => HSLColor.fromColor(this).lightness;
}
