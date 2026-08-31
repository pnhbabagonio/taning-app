import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:taning/features/settings/presentation/providers/settings_providers.dart';
import 'package:taning/features/tanings/domain/entities/taning.dart';
import 'package:taning/features/tanings/presentation/providers/taning_providers.dart';
import 'package:go_router/go_router.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  DateTime _focusedMonth = DateTime.now();
  DateTime? _selectedDate;
  String _filter = 'all';

  @override
  Widget build(BuildContext context) {
    final taningsAsync = ref.watch(allTaningsProvider);
    final accentColor = ref.watch(accentColorProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        backgroundColor: Colors.transparent,
        actions: [
          _buildMonthSelector(context, accentColor),
          PopupMenuButton<String>(
            icon: Icon(Icons.filter_list, color: accentColor),
            onSelected: (value) {
              setState(() {
                _filter = value;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'all',
                child: Text('All Tanings'),
              ),
              const PopupMenuItem(
                value: 'active',
                child: Text('Active'),
              ),
              const PopupMenuItem(
                value: 'completed',
                child: Text('Completed'),
              ),
              const PopupMenuItem(
                value: 'overdue',
                child: Text('Overdue'),
              ),
            ],
          ),
        ],
      ),
      body: taningsAsync.when(
        data: (tanings) {
          final filteredTanings = _getFilteredTanings(tanings);
          final eventsByDate = _groupTaningsByDate(filteredTanings);
          
          return Column(
            children: [
              _buildCalendarHeader(accentColor),
              _buildCalendarGrid(eventsByDate, accentColor, isDark),
              const SizedBox(height: 16),
              _buildEventsList(filteredTanings, accentColor, isDark),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 48, color: Colors.grey.shade400),
              const SizedBox(height: 16),
              Text('Error loading events: $error'),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  ref.invalidate(allTaningsProvider);
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMonthSelector(BuildContext context, Color accentColor) {
    return IconButton(
      icon: Icon(Icons.calendar_month, color: accentColor),
      onPressed: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: _focusedMonth,
          firstDate: DateTime(2020),
          lastDate: DateTime(2030),
        );
        if (date != null) {
          setState(() {
            _focusedMonth = date;
          });
        }
      },
    );
  }

  Widget _buildCalendarHeader(Color accentColor) {
    final monthFormat = DateFormat('MMMM yyyy');
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              setState(() {
                _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month - 1);
              });
            },
          ),
          Expanded(
            child: Text(
              monthFormat.format(_focusedMonth),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () {
              setState(() {
                _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid(
    Map<DateTime, List<Taning>> eventsByDate,
    Color accentColor,
    bool isDark,
  ) {
    final daysInMonth = DateUtils.getDaysInMonth(_focusedMonth.year, _focusedMonth.month);
    final firstDayOfMonth = DateTime(_focusedMonth.year, _focusedMonth.month, 1);
    final firstWeekday = firstDayOfMonth.weekday;
    final today = DateTime.now();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Weekday headers
          Row(
            children: ['M', 'T', 'W', 'T', 'F', 'S', 'S'].map((day) {
              return Expanded(
                child: Center(
                  child: Text(
                    day,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 4),
          // Calendar grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1.2,
            ),
            itemCount: 42,
            itemBuilder: (context, index) {
              final day = index - firstWeekday + 2;
              if (day < 1 || day > daysInMonth) {
                return const SizedBox.shrink();
              }
              final date = DateTime(_focusedMonth.year, _focusedMonth.month, day);
              final isToday = date.year == today.year && date.month == today.month && date.day == today.day;
              final isSelected = _selectedDate != null &&
                  date.year == _selectedDate!.year &&
                  date.month == _selectedDate!.month &&
                  date.day == _selectedDate!.day;
              final hasEvents = eventsByDate.containsKey(date);

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDate = date;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? accentColor
                        : isToday
                            ? accentColor.withValues(alpha: 0.15)
                            : null,
                    shape: BoxShape.circle,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        day.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : isToday
                                  ? FontWeight.w700
                                  : FontWeight.w400,
                          color: isSelected
                              ? Colors.white
                              : isToday
                                  ? accentColor
                                  : isDark
                                      ? Colors.grey.shade300
                                      : Colors.grey.shade700,
                        ),
                      ),
                      if (hasEvents)
                        Positioned(
                          bottom: 4,
                          child: Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: accentColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEventsList(
    List<Taning> tanings,
    Color accentColor,
    bool isDark,
  ) {
    final filteredEvents = _selectedDate != null
        ? tanings.where((t) {
            final eventDate = t.endDate ?? t.startDate;
            return eventDate != null &&
                eventDate.year == _selectedDate!.year &&
                eventDate.month == _selectedDate!.month &&
                eventDate.day == _selectedDate!.day;
          }).toList()
        : tanings;

    if (filteredEvents.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(32),
        child: Text(
          _selectedDate != null
              ? 'No events on ${DateFormat('MMM d, y').format(_selectedDate!)}'
              : 'Select a date to view events',
          style: TextStyle(
            color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: filteredEvents.length,
        itemBuilder: (context, index) {
          final taning = filteredEvents[index];
          return _buildEventCard(taning, accentColor);
        },
      ),
    );
  }

  Widget _buildEventCard(Taning taning, Color accentColor) {
    final date = taning.endDate ?? taning.startDate;
    final isCompleted = taning.isCompleted;
    final isOverdue = taning.endDate != null && taning.endDate!.isBefore(DateTime.now()) && !isCompleted;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: accentColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              String.fromCharCode(taning.icon.codePoint),
              style: TextStyle(fontSize: 20, color: accentColor),
            ),
          ),
        ),
        title: Text(
          taning.title,
          style: TextStyle(
            fontWeight: isCompleted ? FontWeight.w400 : FontWeight.w600,
            decoration: isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (date != null)
              Text(
                DateFormat('MMM d, y').format(date),
                style: TextStyle(
                  fontSize: 12,
                  color: isOverdue ? Colors.red : Colors.grey.shade600,
                ),
              ),
            if (isCompleted)
              Text(
                '✅ Completed',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.green,
                ),
              ),
            if (isOverdue)
              Text(
                '⚠️ Overdue',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.red,
                ),
              ),
          ],
        ),
        trailing: isCompleted
            ? Icon(Icons.check_circle, color: Colors.green)
            : isOverdue
                ? Icon(Icons.warning, color: Colors.red)
                : null,
        onTap: () {
          // Navigate to detail
          context.push('/detail/${taning.id}');
        },
      ),
    );
  }

  List<Taning> _getFilteredTanings(List<Taning> tanings) {
    switch (_filter) {
      case 'active':
        return tanings.where((t) => !t.isCompleted && !t.isArchived).toList();
      case 'completed':
        return tanings.where((t) => t.isCompleted).toList();
      case 'overdue':
        return tanings.where((t) => 
          !t.isCompleted && 
          !t.isArchived &&
          t.endDate != null &&
          t.endDate!.isBefore(DateTime.now())
        ).toList();
      default:
        return tanings;
    }
  }

  Map<DateTime, List<Taning>> _groupTaningsByDate(List<Taning> tanings) {
    final Map<DateTime, List<Taning>> map = {};
    
    for (final taning in tanings) {
      final date = taning.endDate ?? taning.startDate;
      if (date == null) continue;
      
      final key = DateTime(date.year, date.month, date.day);
      if (!map.containsKey(key)) {
        map[key] = [];
      }
      map[key]!.add(taning);
    }
    
    return map;
  }
}