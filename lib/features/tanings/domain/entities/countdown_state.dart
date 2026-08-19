import 'package:freezed_annotation/freezed_annotation.dart';

part 'countdown_state.freezed.dart';

@freezed
class CountdownState with _$CountdownState {
  const factory CountdownState({
    required CountdownStatus status,
    Duration? totalDuration,
    Duration? remainingDuration,
    Duration? elapsedDuration,
    double? progressPercentage,
    int? currentDay,
    int? totalDays,
    required String formattedRemaining,
    String? formattedElapsed,
    DateTime? targetDate,
    required bool isOverdue,
    String? statusMessage,
    String? statusEmoji,
  }) = _CountdownState;
  
  const CountdownState._();
  
  bool get isActive => status == CountdownStatus.active ||
      status == CountdownStatus.today ||
      status == CountdownStatus.lessThanDay ||
      status == CountdownStatus.lessThanHour;
  
  bool get isFinished => status == CountdownStatus.completed ||
      status == CountdownStatus.ended;
  
  bool get isUpcoming => status == CountdownStatus.upcoming;
}

enum CountdownStatus {
  upcoming,      // Not yet started
  active,        // In progress
  today,         // Target is today
  lessThanDay,   // Less than 24h
  lessThanHour,  // Less than 1h
  completed,     // Finished successfully
  overdue,       // Past the target
  ended,         // Duration completed
}