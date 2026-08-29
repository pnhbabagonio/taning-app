import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taning/app/theme/theme_provider.dart';
import 'package:taning/features/settings/presentation/providers/settings_providers.dart';

class ThemeSelectorDialog extends ConsumerStatefulWidget {
  const ThemeSelectorDialog({super.key});

  @override
  ConsumerState<ThemeSelectorDialog> createState() => _ThemeSelectorDialogState();
}

class _ThemeSelectorDialogState extends ConsumerState<ThemeSelectorDialog> {
  late ThemeModePreference _selectedMode;

  @override
  void initState() {
    super.initState();
    _selectedMode = ref.read(settingsProvider).themeMode;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: const Text('Select Theme'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildThemeOption(
            label: 'System',
            icon: Icons.settings_suggest_outlined,
            mode: ThemeModePreference.system,
          ),
          _buildThemeOption(
            label: 'Light',
            icon: Icons.light_mode_outlined,
            mode: ThemeModePreference.light,
          ),
          _buildThemeOption(
            label: 'Dark',
            icon: Icons.dark_mode_outlined,
            mode: ThemeModePreference.dark,
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
            ref.read(settingsProvider.notifier).setThemeMode(_selectedMode);
            // Also update the theme provider
            ref.read(themeModeProvider.notifier).setThemeMode(_selectedMode);
            Navigator.pop(context);
          },
          child: const Text('Apply'),
        ),
      ],
    );
  }

  Widget _buildThemeOption({
    required String label,
    required IconData icon,
    required ThemeModePreference mode,
  }) {
    final isSelected = _selectedMode == mode;
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? Theme.of(context).primaryColor : null,
      ),
      title: Text(
        label,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          color: isSelected ? Theme.of(context).primaryColor : null,
        ),
      ),
      trailing: isSelected
          ? Icon(
              Icons.check_circle,
              color: Theme.of(context).primaryColor,
            )
          : null,
      onTap: () {
        setState(() {
          _selectedMode = mode;
        });
      },
    );
  }
}