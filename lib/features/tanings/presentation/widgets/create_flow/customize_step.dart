import 'package:flutter/material.dart';
import 'package:taning/features/tanings/domain/entities/taning.dart';
import 'package:taning/features/tanings/presentation/view_models/create_view_model.dart';

class CustomizeStep extends StatefulWidget {
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
  State<CustomizeStep> createState() => _CustomizeStepState();
}

class _CustomizeStepState extends State<CustomizeStep> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
            'Customize your Taning',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Make it yours with colors, icons, and more',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon selector
                  const Text(
                    'Icon',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _IconSelector(
                    selectedIcon: widget.viewModel.selectedIcon,
                    onIconSelected: (icon) {
                      setState(() {
                        widget.viewModel.selectedIcon = icon;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  // Color selector
                  const Text(
                    'Color',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _ColorSelector(
                    selectedColor: widget.viewModel.selectedColor,
                    onColorSelected: (color) {
                      setState(() {
                        widget.viewModel.selectedColor = color;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  // Theme selector
                  const Text(
                    'Theme',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _ThemeSelector(
                    selectedTheme: widget.viewModel.selectedTheme,
                    onThemeSelected: (theme) {
                      setState(() {
                        widget.viewModel.selectedTheme = theme;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  // Countdown style
                  const Text(
                    'Countdown Style',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _StyleSelector(
                    selectedStyle: widget.viewModel.selectedStyle,
                    onStyleSelected: (style) {
                      setState(() {
                        widget.viewModel.selectedStyle = style;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  // Notification settings
                  const Text(
                    'Notifications',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _NotificationSettings(
                    settings: widget.viewModel.notificationSettings,
                    onSettingsChanged: (settings) {
                      setState(() {
                        widget.viewModel.notificationSettings = settings;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Row(
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
                  onPressed: widget.onNext,
                  child: const Text('Preview'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// MARK: - Icon Selector

class _IconSelector extends StatelessWidget {
  final TaningIcon selectedIcon;
  final Function(TaningIcon) onIconSelected;

  const _IconSelector({
    required this.selectedIcon,
    required this.onIconSelected,
  });

  @override
  Widget build(BuildContext context) {
    final icons = [
      const TaningIcon(codePoint: 0xE8ED, family: 'MaterialIcons'), // flight
      const TaningIcon(codePoint: 0xE8F0, family: 'MaterialIcons'), // cake
      const TaningIcon(codePoint: 0xE8F5, family: 'MaterialIcons'), // school
      const TaningIcon(codePoint: 0xE8F8, family: 'MaterialIcons'), // assignment
      const TaningIcon(codePoint: 0xE8FB, family: 'MaterialIcons'), // fitness_center
      const TaningIcon(codePoint: 0xE8FE, family: 'MaterialIcons'), // favorite
      const TaningIcon(codePoint: 0xE8E9, family: 'MaterialIcons'), // event_note
      const TaningIcon(codePoint: 0xE8FD, family: 'MaterialIcons'), // star
      const TaningIcon(codePoint: 0xE8EF, family: 'MaterialIcons'), // favorite
      const TaningIcon(codePoint: 0xE8F1, family: 'MaterialIcons'), // celebration
      const TaningIcon(codePoint: 0xE8F2, family: 'MaterialIcons'), // event
      const TaningIcon(codePoint: 0xE8F3, family: 'MaterialIcons'), // calendar_month
      const TaningIcon(codePoint: 0xE8F4, family: 'MaterialIcons'), // schedule
      const TaningIcon(codePoint: 0xE8F6, family: 'MaterialIcons'), // school
      const TaningIcon(codePoint: 0xE8F7, family: 'MaterialIcons'), // work
      const TaningIcon(codePoint: 0xE8F9, family: 'MaterialIcons'), // emoji_events
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: icons.map((icon) {
        final isSelected = icon.codePoint == selectedIcon.codePoint;
        return InkWell(
          onTap: () => onIconSelected(icon),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
                width: 2,
              ),
            ),
            child: Icon(
              IconData(icon.codePoint, fontFamily: icon.family ?? 'MaterialIcons'),
              color: isSelected ? Colors.white : Colors.grey.shade700,
              size: 24,
            ),
          ),
        );
      }).toList(),
    );
  }
}

// MARK: - Color Selector

class _ColorSelector extends StatelessWidget {
  final TaningColor selectedColor;
  final Function(TaningColor) onColorSelected;

  const _ColorSelector({
    required this.selectedColor,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    final presets = const [
      TaningColor(value: 0xFF4F46E5, name: 'Indigo'),
      TaningColor(value: 0xFF7C3AED, name: 'Purple'),
      TaningColor(value: 0xFFEC4899, name: 'Pink'),
      TaningColor(value: 0xFFEF4444, name: 'Red'),
      TaningColor(value: 0xFFF97316, name: 'Orange'),
      TaningColor(value: 0xFFFCD34D, name: 'Gold'),
      TaningColor(value: 0xFF22C55E, name: 'Green'),
      TaningColor(value: 0xFF14B8A6, name: 'Teal'),
      TaningColor(value: 0xFF0EA5E9, name: 'Sky'),
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: presets.map((color) {
        final isSelected = color.value == selectedColor.value;
        return InkWell(
          onTap: () => onColorSelected(color),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Color(color.value),
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
                width: 3,
              ),
            ),
            child: isSelected
                ? const Icon(Icons.check, color: Colors.white, size: 20)
                : null,
          ),
        );
      }).toList(),
    );
  }
}

// MARK: - Theme Selector

class _ThemeSelector extends StatelessWidget {
  final TaningTheme selectedTheme;
  final Function(TaningTheme) onThemeSelected;

  const _ThemeSelector({
    required this.selectedTheme,
    required this.onThemeSelected,
  });

  @override
  Widget build(BuildContext context) {
    final themes = [
      {'theme': TaningTheme.midnight, 'label': 'Midnight', 'color': Colors.indigo},
      {'theme': TaningTheme.sunrise, 'label': 'Sunrise', 'color': Colors.orange},
      {'theme': TaningTheme.forest, 'label': 'Forest', 'color': Colors.green},
      {'theme': TaningTheme.ocean, 'label': 'Ocean', 'color': Colors.blue},
      {'theme': TaningTheme.sakura, 'label': 'Sakura', 'color': Colors.pink},
      {'theme': TaningTheme.mono, 'label': 'Mono', 'color': Colors.grey},
      {'theme': TaningTheme.filipino, 'label': 'Filipino', 'color': Colors.amber},
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: themes.map((themeData) {
        final isSelected = selectedTheme == themeData['theme'];
        final color = themeData['color'] as Color;
        return ChoiceChip(
          label: Text(themeData['label'] as String),
          selected: isSelected,
          onSelected: (_) => onThemeSelected(themeData['theme'] as TaningTheme),
          selectedColor: color.withOpacity(0.2),
          backgroundColor: Colors.grey.shade100,
          avatar: CircleAvatar(
            backgroundColor: color,
            radius: 8,
          ),
        );
      }).toList(),
    );
  }
}

// MARK: - Style Selector

class _StyleSelector extends StatelessWidget {
  final CountdownStyle selectedStyle;
  final Function(CountdownStyle) onStyleSelected;

  const _StyleSelector({
    required this.selectedStyle,
    required this.onStyleSelected,
  });

  @override
  Widget build(BuildContext context) {
    final styles = [
      {'style': CountdownStyle.simple, 'label': 'Simple', 'example': '14d'},
      {'style': CountdownStyle.detailed, 'label': 'Detailed', 'example': '14d 6h 42m'},
      {'style': CountdownStyle.full, 'label': 'Full', 'example': '14d 6h 42m 12s'},
      {'style': CountdownStyle.progress, 'label': 'Progress', 'example': 'Day 14/30'},
      {'style': CountdownStyle.calendar, 'label': 'Calendar', 'example': '14d • Aug 24'},
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: styles.map((styleData) {
        final isSelected = selectedStyle == styleData['style'];
        return FilterChip(
          label: Text(styleData['label'] as String),
          selected: isSelected,
          onSelected: (_) => onStyleSelected(styleData['style'] as CountdownStyle),
          avatar: Text(
            styleData['example'] as String,
            style: const TextStyle(fontSize: 10),
          ),
        );
      }).toList(),
    );
  }
}

// MARK: - Notification Settings

class _NotificationSettings extends StatefulWidget {
  final NotificationSettings settings;
  final Function(NotificationSettings) onSettingsChanged;

  const _NotificationSettings({
    required this.settings,
    required this.onSettingsChanged,
  });

  @override
  State<_NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<_NotificationSettings> {
  late NotificationSettings _settings;

  @override
  void initState() {
    super.initState();
    _settings = widget.settings;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('Enable notifications'),
              value: _settings.enabled,
              onChanged: (value) {
                setState(() {
                  _settings = _settings.copyWith(enabled: value);
                });
                widget.onSettingsChanged(_settings);
              },
            ),
            if (_settings.enabled) ...[
              const Divider(),
              _buildNotificationOption(
                '1 day before',
                _settings.oneDayBefore,
                (value) {
                  setState(() {
                    _settings = _settings.copyWith(oneDayBefore: value);
                  });
                  widget.onSettingsChanged(_settings);
                },
              ),
              _buildNotificationOption(
                '3 days before',
                _settings.threeDaysBefore,
                (value) {
                  setState(() {
                    _settings = _settings.copyWith(threeDaysBefore: value);
                  });
                  widget.onSettingsChanged(_settings);
                },
              ),
              _buildNotificationOption(
                '7 days before',
                _settings.sevenDaysBefore,
                (value) {
                  setState(() {
                    _settings = _settings.copyWith(sevenDaysBefore: value);
                  });
                  widget.onSettingsChanged(_settings);
                },
              ),
              _buildNotificationOption(
                '1 hour before',
                _settings.oneHourBefore,
                (value) {
                  setState(() {
                    _settings = _settings.copyWith(oneHourBefore: value);
                  });
                  widget.onSettingsChanged(_settings);
                },
              ),
              _buildNotificationOption(
                '30 minutes before',
                _settings.thirtyMinutesBefore,
                (value) {
                  setState(() {
                    _settings = _settings.copyWith(thirtyMinutesBefore: value);
                  });
                  widget.onSettingsChanged(_settings);
                },
              ),
              _buildNotificationOption(
                'At exact time',
                _settings.atExactTime,
                (value) {
                  setState(() {
                    _settings = _settings.copyWith(atExactTime: value);
                  });
                  widget.onSettingsChanged(_settings);
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationOption(
    String label,
    bool value,
    Function(bool) onChanged,
  ) {
    return CheckboxListTile(
      title: Text(label),
      value: value,
      onChanged: (newValue) => onChanged(newValue ?? false),
      contentPadding: EdgeInsets.zero,
    );
  }
}