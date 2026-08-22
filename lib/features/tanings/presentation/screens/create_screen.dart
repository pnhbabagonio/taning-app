import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taning/features/tanings/presentation/providers/taning_providers.dart';
import 'package:taning/features/tanings/presentation/view_models/create_view_model.dart';
import 'package:taning/features/tanings/presentation/widgets/create_flow/create_flow.dart';

class CreateScreen extends ConsumerStatefulWidget {
  const CreateScreen({super.key});

  @override
  ConsumerState<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends ConsumerState<CreateScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  final CreateViewModel _createViewModel = CreateViewModel();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildProgressIndicator(),
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
                  viewModel: _createViewModel,
                  onNext: () => _goToStep(1),
                ),
                DateTimeStep(
                  viewModel: _createViewModel,
                  onNext: () => _goToStep(2),
                  onBack: () => _goToStep(0),
                ),
                TypeStep(
                  viewModel: _createViewModel,
                  onNext: () => _goToStep(3),
                  onBack: () => _goToStep(1),
                ),
                CustomizeStep(
                  viewModel: _createViewModel,
                  onNext: () => _goToStep(4),
                  onBack: () => _goToStep(2),
                ),
                PreviewStep(
                  viewModel: _createViewModel,
                  onBack: () => _goToStep(3),
                  onCreate: _createTaning,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('New Taning'),
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          if (_currentStep > 0) {
            _showExitConfirmation();
          } else {
            Navigator.pop(context);
          }
        },
      ),
      actions: [
        if (_currentStep > 0)
          TextButton(
            onPressed: _resetCreation,
            child: const Text('Reset'),
          ),
      ],
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: List.generate(5, (index) {
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
                          ? Theme.of(context).primaryColor
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                if (index < 4) const SizedBox(width: 4),
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

  void _resetCreation() {
    setState(() {
      _createViewModel.reset();
      _currentStep = 0;
      _pageController.jumpToPage(0);
    });
  }

  void _showExitConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text('Exit creation?'),
        content: const Text(
          'Your progress will be lost. Are you sure you want to exit?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Continue'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Exit', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _createTaning() async {
    try {
      final taning = _createViewModel.buildTaning();
      await ref.read(tandingRepositoryProvider).save(taning);

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${taning.title} created! 🎉'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error creating Taning: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }
}