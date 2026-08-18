// lib/features/tanings/domain/entities/countdown_state.dart
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
  }) = _CountdownState;
}

enum CountdownStatus {
  upcoming,
  active,
  today,
  lessThanDay,
  lessThanHour,
  completed,
  overdue,
  ended,
}