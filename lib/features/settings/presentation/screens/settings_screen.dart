import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:taning/features/settings/presentation/providers/settings_providers.dart';
import 'package:taning/features/settings/presentation/widgets/accent_color_picker.dart';
import 'package:taning/features/settings/presentation/widgets/theme_selector_dialog.dart';
import 'package:taning/features/tanings/presentation/widgets/taning_list.dart';
import 'package:taning/core/services/notification_service.dart';
import 'package:taning/app/theme/theme_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  String? _appVersion;

  @override
  void initState() {
    super.initState();
    _loadAppVersion();
  }

  Future<void> _loadAppVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        _appVersion = packageInfo.version;
      });
    } catch (_) {
      setState(() {
        _appVersion = '1.0.0';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final accentColor = settings.accentColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            title: 'Appearance',
            children: [
              _buildSettingTile(
                icon: Icons.dark_mode_outlined,
                title: 'Theme',
                subtitle: _getThemeLabel(settings.themeMode),
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (context) => const ThemeSelectorDialog(),
                  );
                  setState(() {});
                },
                accentColor: accentColor,
              ),
              _buildSettingTile(
                icon: Icons.color_lens_outlined,
                title: 'Accent Color',
                subtitle: 'Customize app accent',
                trailing: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: accentColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                  ),
                ),
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (context) => const AccentColorPicker(),
                  );
                  setState(() {});
                },
                accentColor: accentColor,
              ),
            ],
          ),
          _buildSection(
            title: 'Home Screen',
            children: [
              _buildSettingTile(
                icon: Icons.view_quilt_outlined,
                title: 'Default View',
                subtitle: _getViewLabel(settings.defaultView),
                onTap: () => _showViewSelector(settings, accentColor),
                accentColor: accentColor,
              ),
              _buildSettingTile(
                icon: Icons.sort_outlined,
                title: 'Default Sort',
                subtitle: _getSortLabel(settings.defaultSort),
                onTap: () => _showSortSelector(settings, accentColor),
                accentColor: accentColor,
              ),
            ],
          ),
          _buildSection(
            title: 'Notifications',
            children: [
              SwitchListTile(
                secondary: Icon(
                  Icons.notifications_outlined,
                  size: 22,
                  color: accentColor,
                ),
                title: const Text('Enable Notifications'),
                subtitle: const Text('Receive reminders for your Tanings'),
                value: settings.notificationsEnabled,
                onChanged: (value) async {
                  await ref
                      .read(settingsProvider.notifier)
                      .setNotificationsEnabled(value);
                  if (value) {
                    await NotificationService().requestPermissions();
                  }
                },
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                activeThumbColor: accentColor,
              ),
            ],
          ),
          _buildSection(
            title: 'About',
            children: [
              _buildSettingTile(
                icon: Icons.info_outline,
                title: 'Version',
                subtitle: _appVersion ?? 'Loading...',
                onTap: () {},
                accentColor: accentColor,
              ),
              _buildSettingTile(
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy Policy',
                onTap: () => _showPrivacyPolicyDialog(context, accentColor),
                accentColor: accentColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getThemeLabel(ThemeModePreference mode) {
    switch (mode) {
      case ThemeModePreference.system:
        return 'System';
      case ThemeModePreference.light:
        return 'Light';
      case ThemeModePreference.dark:
        return 'Dark';
    }
  }

  String _getViewLabel(TaningListVariant view) {
    switch (view) {
      case TaningListVariant.list:
        return 'List';
      case TaningListVariant.grid:
        return 'Grid';
      case TaningListVariant.focus:
        return 'Focus';
    }
  }

  String _getSortLabel(String sort) {
    switch (sort) {
      case 'soonest':
        return 'Soonest';
      case 'latest':
        return 'Latest';
      case 'created':
        return 'Recently Created';
      case 'alphabetical':
        return 'Alphabetical';
      default:
        return sort;
    }
  }

  void _showViewSelector(SettingsState settings, Color accentColor) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Default View',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              ...TaningListVariant.values.map((view) {
                final isSelected = settings.defaultView == view;
                return ListTile(
                  title: Text(_getViewLabel(view)),
                  trailing: isSelected
                      ? Icon(
                          Icons.check_circle,
                          color: accentColor,
                        )
                      : null,
                  onTap: () {
                    ref.read(settingsProvider.notifier).setDefaultView(view);
                    Navigator.pop(context);
                    setState(() {});
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _showSortSelector(SettingsState settings, Color accentColor) {
    final sorts = [
      {'value': 'soonest', 'label': 'Soonest'},
      {'value': 'latest', 'label': 'Latest'},
      {'value': 'created', 'label': 'Recently Created'},
      {'value': 'alphabetical', 'label': 'Alphabetical'},
    ];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Default Sort',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              ...sorts.map((sort) {
                final isSelected = settings.defaultSort == sort['value'];
                return ListTile(
                  title: Text(sort['label']!),
                  trailing: isSelected
                      ? Icon(
                          Icons.check_circle,
                          color: accentColor,
                        )
                      : null,
                  onTap: () {
                    ref
                        .read(settingsProvider.notifier)
                        .setDefaultSort(sort['value']!);
                    Navigator.pop(context);
                    setState(() {});
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _showPrivacyPolicyDialog(BuildContext context, Color accentColor) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text('Privacy Policy'),
        content: const Text(
          'Taning respects your privacy. All your data is stored locally on your device. '
          'No personal information is collected or shared with third parties.\n\n'
          'Your Tanings, preferences, and settings are never sent to any server without your explicit consent.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: accentColor,
            ),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Card(
          child: Column(
            children: children,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    String? subtitle,
    VoidCallback? onTap,
    Widget? trailing,
    Color? accentColor,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        size: 22,
        color: accentColor,
      ),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: trailing ?? Icon(
        Icons.chevron_right,
        size: 20,
        color: accentColor,
      ),
      onTap: onTap,
    );
  }
}