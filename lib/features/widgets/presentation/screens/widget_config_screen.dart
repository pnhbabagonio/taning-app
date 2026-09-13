import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taning/plugins/widget_bridge.dart';
import 'package:taning/features/tanings/domain/entities/taning.dart';
import 'package:taning/features/widgets/presentation/providers/widget_providers.dart';
import 'package:taning/features/tanings/presentation/providers/taning_providers.dart';

class WidgetConfigScreen extends ConsumerStatefulWidget {
  const WidgetConfigScreen({super.key});

  @override
  ConsumerState<WidgetConfigScreen> createState() => _WidgetConfigScreenState();
}

class _WidgetConfigScreenState extends ConsumerState<WidgetConfigScreen> {
  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    final config = ref.watch(widgetConfigProvider);
    final taningsAsync = ref.watch(activeTaningsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget Settings'),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: _isSaving ? null : _saveSettings,
            child: const Text('Save'),
          ),
        ],
      ),
      body: taningsAsync.when(
        data: (tanings) {
          if (tanings.isEmpty) {
            return const _EmptyWidgetConfig();
          }
          return _WidgetConfigContent(
            tanings: tanings,
            config: config,
            onConfigChanged: (newConfig) {
              ref.read(widgetConfigProvider.notifier).state = newConfig;
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error loading Tanings: $error'),
        ),
      ),
    );
  }

  void _saveSettings() async {
    setState(() => _isSaving = true);

    try {
      final repository = ref.read(taningRepositoryProvider);
      final tanings = await repository.getAll();
      await WidgetBridge.updateWidgetsWithAllTanings(tanings);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Widget settings saved!'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
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

class _EmptyWidgetConfig extends StatelessWidget {
  const _EmptyWidgetConfig();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.widgets_outlined, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          const Text(
            'No Tanings available',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          const Text(
            'Create a Taning first to add to your widget',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/create'),
            child: const Text('Create Taning'),
          ),
        ],
      ),
    );
  }
}

class _WidgetConfigContent extends StatefulWidget {
  final List<Taning> tanings;
  final WidgetConfig config;
  final Function(WidgetConfig) onConfigChanged;

  const _WidgetConfigContent({
    required this.tanings,
    required this.config,
    required this.onConfigChanged,
  });

  @override
  State<_WidgetConfigContent> createState() => _WidgetConfigContentState();
}

class _WidgetConfigContentState extends State<_WidgetConfigContent> {
  late bool _showIcons;
  late bool _showDates;
  late bool _showProgress;

  @override
  void initState() {
    super.initState();
    _showIcons = widget.config.showIcons;
    _showDates = widget.config.showDates;
    _showProgress = widget.config.showProgress;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Widget preview
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Widget Preview',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xFF1A1A1A),
                  ),
                  child: _buildWidgetPreview(),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Info card
        Card(
          color: Colors.blue.shade50,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.blue.shade700),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'The widget shows your top upcoming Tanings sorted by soonest. '
                    'Small size shows 1, medium shows 4, large shows 6.',
                    style: TextStyle(
                      color: Colors.blue.shade700,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Options
        Card(
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('Show Icons'),
                subtitle: const Text('Display Taning icons'),
                value: _showIcons,
                onChanged: (value) {
                  setState(() {
                    _showIcons = value;
                    _updateConfig();
                  });
                },
              ),
              const Divider(height: 1),
              SwitchListTile(
                title: const Text('Show Dates'),
                subtitle: const Text('Display target dates'),
                value: _showDates,
                onChanged: (value) {
                  setState(() {
                    _showDates = value;
                    _updateConfig();
                  });
                },
              ),
              const Divider(height: 1),
              SwitchListTile(
                title: const Text('Show Progress'),
                subtitle: const Text('Display progress indicators'),
                value: _showProgress,
                onChanged: (value) {
                  setState(() {
                    _showProgress = value;
                    _updateConfig();
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWidgetPreview() {
    // Sort the same way as the widget
    final sorted = List<Taning>.from(widget.tanings)
      ..sort((a, b) {
        if (a.isPinned && !b.isPinned) return -1;
        if (!a.isPinned && b.isPinned) return 1;
        final aDate = a.endDate ?? a.startDate ?? DateTime(2100);
        final bDate = b.endDate ?? b.startDate ?? DateTime(2100);
        return aDate.compareTo(bDate);
      });

    final preview = sorted.take(4).toList();
    final now = DateTime.now();

    return Column(
      children: [
        Row(
          children: [
            const Text(
              'TANING',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            const Spacer(),
            Text(
              '▸',
              style: TextStyle(color: Colors.grey.shade500, fontSize: 10),
            ),
          ],
        ),
        const Divider(color: Colors.white24, height: 12),
        ...preview.map((t) => _buildPreviewRow(t, now)),
      ],
    );
  }

  Widget _buildPreviewRow(Taning taning, DateTime now) {
    final icon = String.fromCharCode(taning.icon.codePoint);
    final target = taning.endDate ?? taning.startDate;
    String countdown = '—';
    if (target != null) {
      final diff = target.difference(now);
      if (diff.isNegative) {
        countdown = 'Overdue';
      } else if (diff.inDays > 0) {
        countdown = '${diff.inDays}d';
      } else if (diff.inHours > 0) {
        countdown = '${diff.inHours}h';
      } else {
        countdown = '${diff.inMinutes}m';
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          if (_showIcons) ...[
            Text(icon, style: const TextStyle(fontSize: 12)),
            const SizedBox(width: 6),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _showIcons && taning.isPinned ? '📌 ${taning.title}' : taning.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (_showDates && target != null)
                  Text(
                    '${target.month}/${target.day}/${target.year}',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 9,
                    ),
                  ),
              ],
            ),
          ),
          Text(
            countdown,
            style: TextStyle(
              color: taning.color.toColor(),
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _updateConfig() {
    widget.onConfigChanged(
      WidgetConfig(
        showIcons: _showIcons,
        showDates: _showDates,
        showProgress: _showProgress,
      ),
    );
  }
}