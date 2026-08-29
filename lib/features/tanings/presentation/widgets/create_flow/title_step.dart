import 'package:flutter/material.dart';
import 'package:taning/features/tanings/presentation/view_models/create_view_model.dart';

class TitleStep extends StatefulWidget {
  final CreateViewModel viewModel;
  final VoidCallback onNext;

  const TitleStep({
    super.key,
    required this.viewModel,
    required this.onNext,
  });

  @override
  State<TitleStep> createState() => _TitleStepState();
}

class _TitleStepState extends State<TitleStep> {
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
                onTap: () {
                  _titleController.text = 'Vacation';
                  widget.viewModel.title = 'Vacation';
                  setState(() {});
                },
              ),
              _TemplateChip(
                label: '🎓 Graduation',
                onTap: () {
                  _titleController.text = 'Graduation';
                  widget.viewModel.title = 'Graduation';
                  setState(() {});
                },
              ),
              _TemplateChip(
                label: '🎂 Birthday',
                onTap: () {
                  _titleController.text = 'Birthday';
                  widget.viewModel.title = 'Birthday';
                  setState(() {});
                },
              ),
              _TemplateChip(
                label: '🏃 30-Day Challenge',
                onTap: () {
                  _titleController.text = '30-Day Challenge';
                  widget.viewModel.title = '30-Day Challenge';
                  setState(() {});
                },
              ),
              _TemplateChip(
                label: '📝 Deadline',
                onTap: () {
                  _titleController.text = 'Deadline';
                  widget.viewModel.title = 'Deadline';
                  setState(() {});
                },
              ),
              _TemplateChip(
                label: '💍 Anniversary',
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

  const _TemplateChip({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(label),
      onPressed: onTap,
      backgroundColor: Colors.grey.shade100,
    );
  }
}