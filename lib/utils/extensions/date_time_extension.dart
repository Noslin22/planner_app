import 'package:planner_app/domain/models/activitiy_model.dart';

import '../../ui/core/localization/app_localization.dart';

extension DateTimeExtension on DateTime {
  String toFormattedTime() {
    return "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}h";
  }

  String toFormattedDate(AppLocalization localization) {
    final String monthName;

    switch (month) {
      case 1:
        monthName = localization.january;
      case 2:
        monthName = localization.february;
      case 3:
        monthName = localization.march;
      case 4:
        monthName = localization.april;
      case 5:
        monthName = localization.mayLong;
      case 6:
        monthName = localization.june;
      case 7:
        monthName = localization.july;
      case 8:
        monthName = localization.august;
      case 9:
        monthName = localization.september;
      case 10:
        monthName = localization.octuber;
      case 11:
        monthName = localization.november;
      default:
        monthName = localization.december;
    }
    return "$day ${localization.ofPrep} $monthName";
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
