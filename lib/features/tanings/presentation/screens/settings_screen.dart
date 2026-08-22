import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                subtitle: 'Light, Dark, or System',
                onTap: () {},
              ),
              _buildSettingTile(
                icon: Icons.color_lens_outlined,
                title: 'Accent Color',
                subtitle: 'Customize app accent',
                onTap: () {},
              ),
            ],
          ),
          _buildSection(
            title: 'Home Screen',
            children: [
              _buildSettingTile(
                icon: Icons.view_quilt_outlined,
                title: 'Default View',
                subtitle: 'List, Grid, or Focus',
                onTap: () {},
              ),
              _buildSettingTile(
                icon: Icons.sort_outlined,
                title: 'Default Sort',
                subtitle: 'Soonest, Latest, etc.',
                onTap: () {},
              ),
            ],
          ),
          _buildSection(
            title: 'Notifications',
            children: [
              _buildSettingTile(
                icon: Icons.notifications_outlined,
                title: 'Enable Notifications',
                subtitle: 'Receive reminders',
                onTap: () {},
                trailing: Switch(
                  value: true,
                  onChanged: (_) {},
                ),
              ),
            ],
          ),
          _buildSection(
            title: 'About',
            children: [
              _buildSettingTile(
                icon: Icons.info_outline,
                title: 'Version',
                subtitle: '1.0.0',
                onTap: () {},
              ),
              _buildSettingTile(
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy Policy',
                onTap: () {},
              ),
            ],
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
  }) {
    return ListTile(
      leading: Icon(icon, size: 22),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: trailing ?? const Icon(Icons.chevron_right, size: 20),
      onTap: onTap,
    );
  }
}