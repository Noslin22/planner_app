import 'package:flutter/material.dart';
import 'package:planner_app/ui/core/localization/app_localization.dart';

extension DateRangeExtension on DateTimeRange {
  String longFormat(AppLocalization localization) {
    final String month;

    switch (end.month) {
      case 1:
        month = localization.january;
      case 2:
        month = localization.february;
      case 3:
        month = localization.march;
      case 4:
        month = localization.april;
      case 5:
        month = localization.mayLong;
      case 6:
        month = localization.june;
      case 7:
        month = localization.july;
      case 8:
        month = localization.august;
      case 9:
        month = localization.september;
      case 10:
        month = localization.octuber;
      case 11:
        month = localization.november;
      default:
        month = localization.december;
    }
    return "${start.day} ${localization.toPrep} ${end.day} ${localization.ofPrep} $month";
  }

  String shortFormat(AppLocalization localization) {
    final String month;

    switch (end.month) {
      case 1:
        month = localization.jan;
      case 2:
        month = localization.feb;
      case 3:
        month = localization.mar;
      case 4:
        month = localization.apr;
      case 5:
        month = localization.may;
      case 6:
        month = localization.jun;
      case 7:
        month = localization.jul;
      case 8:
        month = localization.aug;
      case 9:
        month = localization.sep;
      case 10:
        month = localization.oct;
      case 11:
        month = localization.nov;
      default:
        month = localization.dec;
    }
    return "${start.day} ${localization.toPrep} ${end.day} ${localization.ofPrep} $month";
  }
}
