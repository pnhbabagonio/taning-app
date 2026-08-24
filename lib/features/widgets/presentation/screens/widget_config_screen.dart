import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      final config = ref.read(widgetConfigProvider);
      if (config.taningId.isNotEmpty) {
        final taning = await ref.read(taningProvider(config.taningId).future);
        if (taning != null) {
          await WidgetBridge.updateWidgetData(taning);
        }
      }

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
          Icon(
            Icons.widgets_outlined,
            size: 64,
            color: Colors.grey.shade400,
          ),
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
  late String _selectedId;
  late bool _showProgress;
  late bool _showIcon;
  late int _theme;

  @override
  void initState() {
    super.initState();
    _selectedId = widget.config.taningId;
    _showProgress = widget.config.showProgress;
    _showIcon = widget.config.showIcon;
    _theme = widget.config.theme;
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
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: _getSelectedColor(),
                  ),
                  child: _buildWidgetPreview(),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Select Taning
        Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Select Taning',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ...widget.tanings.map((taning) {
                final isSelected = _selectedId == taning.id;
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: taning.color.toColor(),
                    radius: 12,
                    child: Text(
                      String.fromCharCode(taning.icon.codePoint),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  title: Text(taning.title),
                  trailing: isSelected
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : null,
                  onTap: () {
                    setState(() {
                      _selectedId = taning.id;
                      _updateConfig();
                    });
                  },
                );
              }),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Options
        Card(
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('Show Progress'),
                subtitle: const Text('Display progress bar'),
                value: _showProgress,
                onChanged: (value) {
                  setState(() {
                    _showProgress = value;
                    _updateConfig();
                  });
                },
              ),
              const Divider(height: 1),
              SwitchListTile(
                title: const Text('Show Icon'),
                subtitle: const Text('Display Taning icon'),
                value: _showIcon,
                onChanged: (value) {
                  setState(() {
                    _showIcon = value;
                    _updateConfig();
                  });
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Help text
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
                    'Add the Taning widget to your home screen to see your countdown at a glance.',
                    style: TextStyle(
                      color: Colors.blue.shade700,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Color _getSelectedColor() {
    final taning = widget.tanings.firstWhere(
      (t) => t.id == _selectedId,
      orElse: () => widget.tanings.first,
    );
    return taning.color.toColor();
  }

  Widget _buildWidgetPreview() {
    final taning = widget.tanings.firstWhere(
      (t) => t.id == _selectedId,
      orElse: () => widget.tanings.first,
    );
    
    final color = taning.color.toColor();
    final icon = String.fromCharCode(taning.icon.codePoint);

    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (_showIcon)
                Text(icon, style: const TextStyle(fontSize: 16)),
              if (_showIcon) const SizedBox(width: 8),
              Expanded(
                child: Text(
                  taning.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            '14d 6h',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          if (_showProgress)
            Container(
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(2),
              ),
              child: FractionallySizedBox(
                widthFactor: 0.67,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _updateConfig() {
    widget.onConfigChanged(
      WidgetConfig(
        taningId: _selectedId,
        showProgress: _showProgress,
        showIcon: _showIcon,
        theme: _theme,
      ),
    );
  }
}