import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taning/features/tanings/domain/entities/taning.dart';
import 'package:taning/features/tanings/presentation/widgets/taning_card.dart';
import 'package:taning/features/tanings/presentation/providers/taning_providers.dart';

class TaningList extends ConsumerStatefulWidget {
  final List<Taning> tanings;
  final TaningListVariant variant;

  const TaningList({
    super.key,
    required this.tanings,
    this.variant = TaningListVariant.list,
  });

  @override
  ConsumerState<TaningList> createState() => _TaningListState();
}

class _TaningListState extends ConsumerState<TaningList> {
  final String _sortBy = 'soonest';
  final String _filter = 'all';

  @override
  Widget build(BuildContext context) {
    final sortedTanings = _getSortedTanings();
    final filteredTanings = _getFilteredTanings(sortedTanings);

    if (filteredTanings.isEmpty) {
      return const _EmptyFilterState();
    }

    switch (widget.variant) {
      case TaningListVariant.list:
        return _buildListView(filteredTanings);
      case TaningListVariant.grid:
        return _buildGridView(filteredTanings);
      case TaningListVariant.focus:
        return _buildFocusView(filteredTanings);
    }
  }

  Widget _buildListView(List<Taning> tanings) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 100),
      itemCount: tanings.length,
      itemBuilder: (context, index) {
        return TaningCard(
          taning: tanings[index],
          onTap: () => _navigateToDetail(tanings[index].id),
          onLongPress: () => _showCardOptions(tanings[index]),
        );
      },
    );
  }

  Widget _buildGridView(List<Taning> tanings) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.9,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: tanings.length,
      itemBuilder: (context, index) {
        return TaningCard(
          taning: tanings[index],
          variant: TaningCardVariant.mini,
          onTap: () => _navigateToDetail(tanings[index].id),
        );
      },
    );
  }

  /// Focus view with square card, proper sizing, and adjusted position
  Widget _buildFocusView(List<Taning> tanings) {
    final taning = tanings.first;
    final screenSize = MediaQuery.of(context).size;
    final maxSize = screenSize.width < screenSize.height
        ? screenSize.width * 0.85
        : screenSize.height * 0.75;

    // Make it slightly larger to accommodate content
    final cardSize = maxSize.clamp(300.0, 500.0);

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
            top: 40.0, left: 24.0, right: 24.0, bottom: 24.0),
        child: SizedBox(
          width: cardSize,
          height: cardSize,
          child: TaningCard(
            taning: taning,
            variant: TaningCardVariant.focus,
            onTap: () => _navigateToDetail(taning.id),
          ),
        ),
      ),
    );
  }

  List<Taning> _getSortedTanings() {
    final list = List<Taning>.from(widget.tanings);

    switch (_sortBy) {
      case 'soonest':
        list.sort((a, b) {
          final aDate = a.endDate ?? a.startDate ?? a.createdAt;
          final bDate = b.endDate ?? b.startDate ?? b.createdAt;
          return aDate.compareTo(bDate);
        });
        break;
      case 'latest':
        list.sort((a, b) {
          final aDate = a.endDate ?? a.startDate ?? a.createdAt;
          final bDate = b.endDate ?? b.startDate ?? b.createdAt;
          return bDate.compareTo(aDate);
        });
        break;
      case 'created':
        list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case 'alphabetical':
        list.sort((a, b) => a.title.compareTo(b.title));
        break;
    }

    // Pinned items first
    list.sort((a, b) {
      if (a.isPinned && !b.isPinned) return -1;
      if (!a.isPinned && b.isPinned) return 1;
      return 0;
    });

    return list;
  }

  List<Taning> _getFilteredTanings(List<Taning> tanings) {
    switch (_filter) {
      case 'active':
        return tanings.where((t) => !t.isCompleted && !t.isArchived).toList();
      case 'completed':
        return tanings.where((t) => t.isCompleted).toList();
      case 'upcoming':
        return tanings
            .where((t) =>
                !t.isCompleted &&
                !t.isArchived &&
                (t.endDate?.isAfter(DateTime.now()) ?? false))
            .toList();
      case 'overdue':
        return tanings
            .where((t) =>
                !t.isCompleted &&
                !t.isArchived &&
                (t.endDate?.isBefore(DateTime.now()) ?? false))
            .toList();
      default:
        return tanings;
    }
  }

  void _navigateToDetail(String id) {
    // TODO: Navigate to detail screen
  }

  void _showCardOptions(Taning taning) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _TaningOptionsSheet(taning: taning),
    );
  }
}

enum TaningListVariant {
  list,
  grid,
  focus,
}

// MARK: - Options Sheet

class _TaningOptionsSheet extends ConsumerWidget {
  final Taning taning;

  const _TaningOptionsSheet({required this.taning});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: Icon(
              taning.isPinned ? Icons.push_pin : Icons.push_pin_outlined,
            ),
            title: Text(taning.isPinned ? 'Unpin' : 'Pin'),
            onTap: () {
              ref.read(taningRepositoryProvider).togglePin(taning.id);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit_outlined),
            title: const Text('Edit'),
            onTap: () {
              Navigator.pop(context);
              // TODO: Navigate to edit
            },
          ),
          ListTile(
            leading: const Icon(Icons.share_outlined),
            title: const Text('Share'),
            onTap: () {
              Navigator.pop(context);
              // TODO: Share
            },
          ),
          ListTile(
            leading: const Icon(Icons.archive_outlined),
            title: const Text('Archive'),
            onTap: () {
              ref.read(taningRepositoryProvider).archive(taning.id);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete_outline, color: Colors.red),
            title: const Text('Delete', style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pop(context);
              _showDeleteConfirmation(context, taning.id);
            },
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text('Delete Taning?'),
        content: const Text(
          'This action cannot be undone. Are you sure?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ProviderScope.containerOf(context, listen: false)
                  .read(taningRepositoryProvider)
                  .delete(id);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Taning deleted')),
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

// MARK: - Empty Filter State

class _EmptyFilterState extends StatelessWidget {
  const _EmptyFilterState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.filter_list_off,
            size: 48,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          const Text(
            'No Tanings match your filter',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {
              // TODO: Reset filters
            },
            child: const Text('Clear filters'),
          ),
        ],
      ),
    );
  }
}
