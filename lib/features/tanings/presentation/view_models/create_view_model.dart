import 'package:taning/features/tanings/domain/entities/taning.dart';

class CreateViewModel {
  // ── Step 1: Setup ──
  String title = '';
  String? description;
  TaningType type = TaningType.countdown;
  RecurrencePattern? recurrencePattern;

  // ── Step 2: When ──
  // For countdown / countUp / recurring: only endDate or startDate is used.
  // For duration: both are used.
  DateTime? startDate;
  DateTime? endDate;

  // ── Step 3: Customize ──
  TaningIcon selectedIcon = const TaningIcon(codePoint: 0xE8E9);
  TaningColor selectedColor = const TaningColor(value: 0xFF4F46E5);
  CountdownStyle selectedStyle = CountdownStyle.simple;
  NotificationSettings notificationSettings = NotificationSettings.defaults();

  // ── Validation ──
  bool get isTitleValid => title.trim().isNotEmpty;
  bool get isTypeValid =>
      type != TaningType.recurring || recurrencePattern != null;
  bool get isDateValid {
    switch (type) {
      case TaningType.countdown:
      case TaningType.recurring:
        return endDate != null;
      case TaningType.countUp:
        return startDate != null;
      case TaningType.duration:
        return startDate != null && endDate != null;
    }
  }

  bool get canProceedToStep2 => isTitleValid && isTypeValid;
  bool get canProceedToStep3 => isDateValid;
  bool get canCreate => isTitleValid && isTypeValid && isDateValid;

  // ── Reset ──
  void reset() {
    title = '';
    description = null;
    type = TaningType.countdown;
    recurrencePattern = null;
    startDate = null;
    endDate = null;
    selectedIcon = const TaningIcon(codePoint: 0xE8E9);
    selectedColor = const TaningColor(value: 0xFF4F46E5);
    selectedStyle = CountdownStyle.simple;
    notificationSettings = NotificationSettings.defaults();
  }

  // ── Build ──
  Taning buildTaning() {
    return Taning.create(
      title: title.trim(),
      description: description?.trim(),
      type: type,
      startDate: startDate,
      endDate: endDate,
      icon: selectedIcon,
      color: selectedColor,
      countdownStyle: selectedStyle,
      notificationSettings: notificationSettings,
      recurrence: recurrencePattern,
    );
  }

  // ── Recurrence helpers ──
  void setDailyRecurrence({int interval = 1}) {
    recurrencePattern = DailyRecurrence(interval: interval);
  }

  void setWeeklyRecurrence({
    required List<int> weekdays,
    int interval = 1,
  }) {
    recurrencePattern =
        WeeklyRecurrence(weekdays: weekdays, interval: interval);
  }

  void setMonthlyRecurrence({int? dayOfMonth, int interval = 1}) {
    recurrencePattern =
        MonthlyRecurrence(dayOfMonth: dayOfMonth, interval: interval);
  }

  void setYearlyRecurrence({required int month, int? dayOfMonth}) {
    recurrencePattern =
        YearlyRecurrence(month: month, dayOfMonth: dayOfMonth);
  }
}