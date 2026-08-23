import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taning/core/services/notification_service.dart';

class NotificationPermissionBanner extends ConsumerStatefulWidget {
  const NotificationPermissionBanner({super.key});

  @override
  ConsumerState<NotificationPermissionBanner> createState() =>
      _NotificationPermissionBannerState();
}

class _NotificationPermissionBannerState
    extends ConsumerState<NotificationPermissionBanner> {
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Row(
        children: [
          Icon(
            Icons.notifications_active,
            color: Colors.blue.shade700,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Enable Notifications',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Get reminded about your Tanings',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: _requestPermission,
            child: const Text('Enable'),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 16),
            onPressed: () {
              setState(() {
                _isVisible = false;
              });
            },
          ),
        ],
      ),
    );
  }

  void _requestPermission() async {
    try {
      await NotificationService().requestPermissions();
      setState(() {
        _isVisible = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Notifications enabled! 🔔'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to enable notifications: $e'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}