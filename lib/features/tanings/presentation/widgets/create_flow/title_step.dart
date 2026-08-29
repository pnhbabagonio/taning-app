import 'package:flutter/material.dart';
import 'package:taning/features/tanings/presentation/view_models/create_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taning/features/settings/presentation/providers/settings_providers.dart';

class TitleStep extends ConsumerStatefulWidget {
  final CreateViewModel viewModel;
  final VoidCallback onNext;

  const TitleStep({
    super.key,
    required this.viewModel,
    required this.onNext,
  });

  @override
  ConsumerState<TitleStep> createState() => _TitleStepState();
}

class _TitleStepState extends ConsumerState<TitleStep> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.viewModel.title;
    _descriptionController.text = widget.viewModel.description ?? '';
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final accentColor = ref.watch(accentColorProvider);
    
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            "What's your Taning?",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Give it a name and optional description',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 32),
          TextField(
            controller: _titleController,
            focusNode: _focusNode,
            decoration: const InputDecoration(
              labelText: 'Title',
              hintText: 'e.g., Vacation, Exam, 30-Day Challenge',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              widget.viewModel.title = value;
              setState(() {});
            },
            textInputAction: TextInputAction.next,
            onSubmitted: (_) {
              if (widget.viewModel.isTitleValid) {
                widget.onNext();
              }
            },
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: 'Description (optional)',
              hintText: 'Add more details about your Taning',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              widget.viewModel.description = value;
            },
            maxLines: 3,
            textInputAction: TextInputAction.done,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          const Spacer(),
          // Quick templates
          const Text(
            'Quick templates',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _TemplateChip(
                label: '✈️ Vacation',
                accentColor: accentColor,
                isDarkMode: isDarkMode,
                onTap: () {
                  _titleController.text = 'Vacation';
                  widget.viewModel.title = 'Vacation';
                  setState(() {});
                },
              ),
              _TemplateChip(
                label: '🎓 Graduation',
                accentColor: accentColor,
                isDarkMode: isDarkMode,
                onTap: () {
                  _titleController.text = 'Graduation';
                  widget.viewModel.title = 'Graduation';
                  setState(() {});
                },
              ),
              _TemplateChip(
                label: '🎂 Birthday',
                accentColor: accentColor,
                isDarkMode: isDarkMode,
                onTap: () {
                  _titleController.text = 'Birthday';
                  widget.viewModel.title = 'Birthday';
                  setState(() {});
                },
              ),
              _TemplateChip(
                label: '🏃 30-Day Challenge',
                accentColor: accentColor,
                isDarkMode: isDarkMode,
                onTap: () {
                  _titleController.text = '30-Day Challenge';
                  widget.viewModel.title = '30-Day Challenge';
                  setState(() {});
                },
              ),
              _TemplateChip(
                label: '📝 Deadline',
                accentColor: accentColor,
                isDarkMode: isDarkMode,
                onTap: () {
                  _titleController.text = 'Deadline';
                  widget.viewModel.title = 'Deadline';
                  setState(() {});
                },
              ),
              _TemplateChip(
                label: '💍 Anniversary',
                accentColor: accentColor,
                isDarkMode: isDarkMode,
                onTap: () {
                  _titleController.text = 'Anniversary';
                  widget.viewModel.title = 'Anniversary';
                  setState(() {});
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom + 8,
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: widget.viewModel.isTitleValid ? widget.onNext : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey.shade300,
                ),
                child: const Text('Next'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TemplateChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Color accentColor;
  final bool isDarkMode;

  const _TemplateChip({
    required this.label,
    required this.onTap,
    required this.accentColor,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(
        label,
        style: TextStyle(
          color: isDarkMode ? Colors.white : Colors.black87,
        ),
      ),
      onPressed: onTap,
      backgroundColor: isDarkMode 
          ? Colors.grey.shade800 
          : Colors.grey.shade100,
      side: BorderSide(
        color: isDarkMode 
            ? Colors.grey.shade700 
            : Colors.grey.shade300,
        width: 1,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}