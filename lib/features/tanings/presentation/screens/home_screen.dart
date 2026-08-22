import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:taning/features/tanings/presentation/providers/taning_providers.dart';
import 'package:taning/features/tanings/presentation/widgets/taning_list.dart';
import 'package:taning/shared/widgets/empty_state.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String _sortBy = 'soonest';
  String _filter = 'all';
  TaningListVariant _viewMode = TaningListVariant.list;

  @override
  Widget build(BuildContext context) {
    final taningsAsync = ref.watch(activeTaningsProvider);
    
    return Scaffold(
      appBar: _buildAppBar(),
      body: taningsAsync.when(
        data: (tanings) {
          if (tanings.isEmpty) {
            return const EmptyState();
          }
          return TaningList(
            tanings: tanings,
            variant: _viewMode,
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 48,
                color: Colors.grey.shade400,
              ),
              const SizedBox(height: 16),
              Text(
                'Something went wrong',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  ref.invalidate(activeTaningsProvider);
                },
                child: const Text('Try again'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push('/create');
        },
        icon: const Icon(Icons.add),
        label: const Text('New Taning'),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('Taning'),
      backgroundColor: Colors.transparent,
      actions: [
        // View mode toggle
        IconButton(
          icon: Icon(
            _viewMode == TaningListVariant.list 
                ? Icons.view_list 
                : _viewMode == TaningListVariant.grid
                    ? Icons.grid_view
                    : Icons.filter_center_focus,
          ),
          onPressed: _toggleViewMode,
          tooltip: 'Change view',
        ),
        // Sort & Filter
        IconButton(
          icon: const Icon(Icons.tune),
          onPressed: _showSortFilterOptions,
          tooltip: 'Sort & Filter',
        ),
        IconButton(
          icon: const Icon(Icons.settings_outlined),
          onPressed: () {
            context.push('/settings');
          },
          tooltip: 'Settings',
        ),
      ],
    );
  }

  void _toggleViewMode() {
    setState(() {
      switch (_viewMode) {
        case TaningListVariant.list:
          _viewMode = TaningListVariant.grid;
          break;
        case TaningListVariant.grid:
          _viewMode = TaningListVariant.focus;
          break;
        case TaningListVariant.focus:
          _viewMode = TaningListVariant.list;
          break;
      }
    });
  }

  void _showSortFilterOptions() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _SortFilterSheet(
        currentSort: _sortBy,
        currentFilter: _filter,
        onSortChanged: (sort) {
          setState(() => _sortBy = sort);
        },
        onFilterChanged: (filter) {
          setState(() => _filter = filter);
        },
      ),
    );
  }
}

// MARK: - Sort & Filter Sheet

class _SortFilterSheet extends StatefulWidget {
  final String currentSort;
  final String currentFilter;
  final Function(String) onSortChanged;
  final Function(String) onFilterChanged;

  const _SortFilterSheet({
    required this.currentSort,
    required this.currentFilter,
    required this.onSortChanged,
    required this.onFilterChanged,
  });

  @override
  State<_SortFilterSheet> createState() => _SortFilterSheetState();
}

class _SortFilterSheetState extends State<_SortFilterSheet> {
  late String _selectedSort;
  late String _selectedFilter;

  @override
  void initState() {
    super.initState();
    _selectedSort = widget.currentSort;
    _selectedFilter = widget.currentFilter;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Sort by',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          _buildSortOptions(),
          const SizedBox(height: 24),
          const Text(
            'Filter',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          _buildFilterOptions(),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: _applyChanges,
                  child: const Text('Apply'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSortOptions() {
    final sorts = [
      {'value': 'soonest', 'label': 'Soonest'},
      {'value': 'latest', 'label': 'Latest'},
      {'value': 'created', 'label': 'Recently Created'},
      {'value': 'alphabetical', 'label': 'Alphabetical'},
    ];

    return Wrap(
      spacing: 8,
      children: sorts.map((sort) {
        final isSelected = _selectedSort == sort['value'];
        return ChoiceChip(
          label: Text(sort['label']!),
          selected: isSelected,
          onSelected: (_) {
            setState(() {
              _selectedSort = sort['value']!;
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildFilterOptions() {
    final filters = [
      {'value': 'all', 'label': 'All'},
      {'value': 'active', 'label': 'Active'},
      {'value': 'upcoming', 'label': 'Upcoming'},
      {'value': 'overdue', 'label': 'Overdue'},
      {'value': 'completed', 'label': 'Completed'},
    ];

    return Wrap(
      spacing: 8,
      children: filters.map((filter) {
        final isSelected = _selectedFilter == filter['value'];
        return ChoiceChip(
          label: Text(filter['label']!),
          selected: isSelected,
          onSelected: (_) {
            setState(() {
              _selectedFilter = filter['value']!;
            });
          },
        );
      }).toList(),
    );
  }

  void _applyChanges() {
    widget.onSortChanged(_selectedSort);
    widget.onFilterChanged(_selectedFilter);
    Navigator.pop(context);
  }
}