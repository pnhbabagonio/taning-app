import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taning/features/settings/presentation/providers/settings_providers.dart';
import 'package:taning/features/tanings/domain/entities/taning.dart';
import 'package:taning/features/tanings/presentation/providers/taning_providers.dart';
import 'package:taning/features/tanings/presentation/view_models/create_view_model.dart';
import 'package:taning/features/tanings/presentation/widgets/create_flow/customize_step.dart';
import 'package:taning/features/tanings/presentation/widgets/create_flow/date_time_step.dart';
import 'package:taning/features/tanings/presentation/widgets/create_flow/title_step.dart';
import 'package:taning/features/tanings/presentation/widgets/create_flow/type_step.dart';

class EditScreen extends ConsumerStatefulWidget {
  final Taning taning;

  const EditScreen({super.key, required this.taning});

  @override
  ConsumerState<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends ConsumerState<EditScreen> {
  late CreateViewModel _viewModel;
  int _currentStep = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _viewModel = CreateViewModel();
    _loadTaningData();
  }

  void _loadTaningData() {
    final t = widget.taning;
    _viewModel.title = t.title;
    _viewModel.description = t.description;
    _viewModel.startDate = t.startDate;
    _viewModel.endDate = t.endDate;
    _viewModel.isAllDay = t.isAllDay ?? false;
    _viewModel.type = t.type;
    _viewModel.selectedIcon = t.icon;
    _viewModel.selectedColor = t.color;
    _viewModel.selectedTheme = t.theme;
    _viewModel.selectedStyle = t.countdownStyle;
    _viewModel.notificationSettings = t.notificationSettings;
    _viewModel.recurrencePattern = t.recurrence;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = ref.watch(accentColorProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Taning'),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: _saveChanges,
            child: Text(
              'Save',
              style: TextStyle(color: accentColor),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildProgressIndicator(accentColor),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentStep = index;
                });
              },
              children: [
                TitleStep(
                  viewModel: _viewModel,
                  onNext: () => _goToStep(1),
                ),
                DateTimeStep(
                  viewModel: _viewModel,
                  onNext: () => _goToStep(2),
                  onBack: () => _goToStep(0),
                ),
                TypeStep(
                  viewModel: _viewModel,
                  onNext: () => _goToStep(3),
                  onBack: () => _goToStep(1),
                ),
                CustomizeStep(
                  viewModel: _viewModel,
                  onNext: _saveChanges,
                  onBack: () => _goToStep(2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(Color accentColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: List.generate(4, (index) {
          final isActive = index == _currentStep;
          final isCompleted = index < _currentStep;
          
          return Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 3,
                    decoration: BoxDecoration(
                      color: isCompleted || isActive
                          ? accentColor // Use accent color
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                if (index < 3) const SizedBox(width: 4),
              ],
            ),
          );
        }),
      ),
    );
  }

  void _goToStep(int step) {
    _pageController.animateToPage(
      step,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() {
      _currentStep = step;
    });
  }

  void _saveChanges() async {
    if (!_viewModel.canCreate) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all required fields'),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    try {
      final updatedTaning = _viewModel.buildTaning().copyWith(
        id: widget.taning.id,
        createdAt: widget.taning.createdAt,
        isCompleted: widget.taning.isCompleted,
        isArchived: widget.taning.isArchived,
        isPinned: widget.taning.isPinned,
        completedAt: widget.taning.completedAt,
        lastNotifiedAt: widget.taning.lastNotifiedAt,
      );

      await ref.read(taningRepositoryProvider).save(updatedTaning);

      if (mounted) {
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${updatedTaning.title} updated! ✏️'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating Taning: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }
}