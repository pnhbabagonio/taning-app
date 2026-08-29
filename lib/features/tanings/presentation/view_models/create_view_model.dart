import 'package:taning/features/tanings/domain/entities/taning.dart';

class CreateViewModel {
  // Step 1: Title
  String title = '';
  String? description;

  // Step 2: Date & Time
  DateTime? startDate;
  DateTime? endDate;
  bool isAllDay = false;

  // Step 3: Type
  TaningType type = TaningType.countdown;
  RecurrencePattern? recurrencePattern;

  // Step 4: Customization
  TaningIcon selectedIcon = const TaningIcon(codePoint: 0xE8E9);
  TaningColor selectedColor = const TaningColor(value: 0xFF4F46E5);
  TaningTheme selectedTheme = TaningTheme.midnight;
  CountdownStyle selectedStyle = CountdownStyle.detailed;
  NotificationSettings notificationSettings = NotificationSettings.defaults();

  // Validation
  bool get isTitleValid => title.trim().isNotEmpty;
  bool get isDateValid => endDate != null || startDate != null;
  bool get isTypeValid => type != TaningType.recurring || recurrencePattern != null;

  bool get canProceedToStep2 => isTitleValid;
  bool get canProceedToStep3 => isDateValid;
  bool get canProceedToStep4 => isTypeValid;
  bool get canCreate => isTitleValid && isDateValid && isTypeValid;

  void reset() {
    title = '';
    description = null;
    startDate = null;
    endDate = null;
    isAllDay = false;
    type = TaningType.countdown;
    recurrencePattern = null;
    selectedIcon = const TaningIcon(codePoint: 0xE8E9);
    selectedColor = const TaningColor(value: 0xFF4F46E5);
    selectedTheme = TaningTheme.midnight;
    selectedStyle = CountdownStyle.detailed;
    notificationSettings = NotificationSettings.defaults();
  }

  Taning buildTaning() {
    return Taning.create(
      title: title.trim(),
      description: description?.trim(),
      type: type,
      startDate: startDate,
      endDate: endDate,
      icon: selectedIcon,
      color: selectedColor,
      theme: selectedTheme,
      countdownStyle: selectedStyle,
      notificationSettings: notificationSettings,
      recurrence: recurrencePattern,
      isAllDay: isAllDay,
    );
  }

  void setDailyRecurrence({int interval = 1}) {
    recurrencePattern = DailyRecurrence(interval: interval);
  }

  void setWeeklyRecurrence({required List<int> weekdays, int interval = 1}) {
    recurrencePattern = WeeklyRecurrence(weekdays: weekdays, interval: interval);
  }

  void setMonthlyRecurrence({int? dayOfMonth, int interval = 1}) {
    recurrencePattern = MonthlyRecurrence(dayOfMonth: dayOfMonth, interval: interval);
  }

  void setYearlyRecurrence({required int month, int? dayOfMonth}) {
    recurrencePattern = YearlyRecurrence(month: month, dayOfMonth: dayOfMonth);
  }
}
