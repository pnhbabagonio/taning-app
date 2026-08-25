import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taning/features/tanings/domain/entities/taning.dart';
import 'package:taning/core/services/notification_service.dart';
import 'package:taning/features/tanings/presentation/providers/taning_providers.dart';

class NotificationSettingsScreen extends ConsumerStatefulWidget {
  final String taningId;

  const NotificationSettingsScreen({
    super.key,
    required this.taningId,
  });

  @override
  ConsumerState<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends ConsumerState<NotificationSettingsScreen> {
  late NotificationSettings _settings;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _settings = NotificationSettings.defaults();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    // Load settings from the Taning
    final taning = await ref.read(taningProvider(widget.taningId).future);
    if (taning != null) {
      setState(() {
        _settings = taning.notificationSettings;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Settings'),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _saveSettings,
            child: const Text('Save'),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                const SizedBox(height: 16),
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: SwitchListTile(
                    title: const Text('Enable Notifications'),
                    subtitle: const Text('Receive reminders for this Taning'),
                    value: _settings.enabled,
                    onChanged: (value) {
                      setState(() {
                        _settings = _settings.copyWith(enabled: value);
                      });
                    },
                  ),
                ),
                const SizedBox(height: 16),
                if (_settings.enabled) ...[
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Reminders',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Column(
                      children: [
                        _buildCheckboxTile(
                          title: '7 days before',
                          value: _settings.sevenDaysBefore,
                          onChanged: (value) {
                            setState(() {
                              _settings = _settings.copyWith(
                                sevenDaysBefore: value,
                              );
                            });
                          },
                        ),
                        _buildCheckboxTile(
                          title: '3 days before',
                          value: _settings.threeDaysBefore,
                          onChanged: (value) {
                            setState(() {
                              _settings = _settings.copyWith(
                                threeDaysBefore: value,
                              );
                            });
                          },
                        ),
                        _buildCheckboxTile(
                          title: '1 day before',
                          value: _settings.oneDayBefore,
                          onChanged: (value) {
                            setState(() {
                              _settings = _settings.copyWith(
                                oneDayBefore: value,
                              );
                            });
                          },
                        ),
                        _buildCheckboxTile(
                          title: '1 hour before',
                          value: _settings.oneHourBefore,
                          onChanged: (value) {
                            setState(() {
                              _settings = _settings.copyWith(
                                oneHourBefore: value,
                              );
                            });
                          },
                        ),
                        _buildCheckboxTile(
                          title: '30 minutes before',
                          value: _settings.thirtyMinutesBefore,
                          onChanged: (value) {
                            setState(() {
                              _settings = _settings.copyWith(
                                thirtyMinutesBefore: value,
                              );
                            });
                          },
                        ),
                        _buildCheckboxTile(
                          title: 'At exact time',
                          value: _settings.atExactTime,
                          onChanged: (value) {
                            setState(() {
                              _settings = _settings.copyWith(
                                atExactTime: value,
                              );
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Test notification
                  Center(
                    child: TextButton.icon(
                      onPressed: _sendTestNotification,
                      icon: const Icon(Icons.notification_add),
                      label: const Text('Send Test Notification'),
                    ),
                  ),
                ],
              ],
            ),
    );
  }

  Widget _buildCheckboxTile({
    required String title,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return CheckboxListTile(
      title: Text(title),
      value: value,
      onChanged: (newValue) => onChanged(newValue ?? false),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }

  Future<void> _saveSettings() async {
    setState(() => _isLoading = true);

    try {
      final taning = await ref.read(taningProvider(widget.taningId).future);
      if (taning != null) {
        final updated = taning.copyWith(
          notificationSettings: _settings,
          updatedAt: DateTime.now(),
        );
        await ref.read(taningRepositoryProvider).save(updated);
        
        // Reschedule notifications
        // await NotificationScheduler().scheduleForTaning(updated);
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Notification settings saved!'),
              behavior: SnackBarBehavior.floating,
            ),
          );
          Navigator.pop(context);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving settings: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _sendTestNotification() {
    NotificationService().showImmediateNotification(
      title: '🔔 Test Notification',
      body: 'Your Taning notifications are working!',
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Test notification sent!'),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );
  }
}