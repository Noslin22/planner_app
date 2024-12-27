import 'package:planner_app/domain/models/activitiy_model.dart';

import '../../ui/core/localization/app_localization.dart';

extension DateTimeExtension on DateTime {
  String timeFormat() {
    return "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}h";
  }

  /// Returns true if the date is the same as the other date
  /// (ignoring the time part)
  /// [activity] can be a DateTime or an ActivitiyModel
  ///
  /// Example:
  /// ```dart
  /// final date = DateTime.now();
  /// final otherDate = DateTime.now().add(const Duration(days: 1));
  /// final isSameDay = date.isSameDay(otherDate); // false
  /// ```
  bool isSameDay(dynamic activity) {
    assert(activity is DateTime || activity is ActivitiyModel);

    final DateTime other;

    if (activity is ActivitiyModel) {
      other = activity.dateTime;
    } else {
      other = activity;
    }
    return year == other.year && month == other.month && day == other.day;
  }

  String localizedWeekday(AppLocalization localization) {
    switch (weekday) {
      case DateTime.monday:
        return localization.monday;
      case DateTime.tuesday:
        return localization.tuesday;
      case DateTime.wednesday:
        return localization.wednesday;
      case DateTime.thursday:
        return localization.thursday;
      case DateTime.friday:
        return localization.friday;
      case DateTime.saturday:
        return localization.saturday;
      default:
        return localization.sunday;
    }
  }
}
