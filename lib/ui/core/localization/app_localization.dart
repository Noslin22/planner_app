import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:planner_app/ui/core/localization/english_values.dart';
import 'package:planner_app/ui/core/localization/portuguese_values.dart';

class AppLocalization {
  AppLocalization(this.locale);

  final Locale locale;

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization)!;
  }

  static const _localizedValues = <String, Map<String, String>>{
    'en': englishValues,
    'pt': portugueseValues,
  };

  static List<String> languages() => _localizedValues.keys.toList();

  String _get(String label) {
    return _localizedValues[locale.languageCode]![label] ??
        '[${label.toUpperCase()}]';
  }

  String get dot => ".";
  String get welcomeText => _get("welcomeText");
  String get policiesText => _get("policiesText");
  String get useTerms => _get("useTerms");
  String get and => _get("and");
  String get privacyPolicies => _get("privacyPolicies");
  String get where => _get("where");
  String get when => _get("when");
  String get continueT => _get("continueT");
  String get changePlaceDate => _get("changePlaceDate");
  String get toPrep => _get("toPrep");
  String get ofPrep => _get("ofPrep");
  String get january => _get("january");
  String get february => _get("february");
  String get march => _get("march");
  String get april => _get("april");
  String get mayLong => _get("mayLong");
  String get june => _get("june");
  String get july => _get("july");
  String get august => _get("august");
  String get september => _get("september");
  String get octuber => _get("octuber");
  String get november => _get("november");
  String get december => _get("december");
  String get jan => _get("jan");
  String get feb => _get("feb");
  String get mar => _get("mar");
  String get apr => _get("apr");
  String get may => _get("may");
  String get jun => _get("jun");
  String get jul => _get("jul");
  String get aug => _get("aug");
  String get sep => _get("sep");
  String get oct => _get("oct");
  String get nov => _get("nov");
  String get dec => _get("dec");
  String get errorWhileLoadingCities => _get("errorWhileLoadingCities");
  String get tryAgain => _get("tryAgain");
  String get confirmTrip => _get("confirmTrip");
  String get guestsHint => _get("guestsHint");
  String get selectedGuests => _get("selectedGuests");
  String get guestsText => _get("guestsText");
  String get emailHint => _get("emailHint");
  String get inviteLabel => _get("inviteLabel");
  String invitedGuests(int guests) {
    if (guests == 0) {
      return '';
    }
    return "$guests ${_get("invitedGuests")}";
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) =>
      AppLocalization.languages().contains(locale.languageCode);

  @override
  Future<AppLocalization> load(Locale locale) {
    return SynchronousFuture<AppLocalization>(AppLocalization(locale));
  }

  @override
  bool shouldReload(AppLocalizationDelegate old) => this != old;
}
