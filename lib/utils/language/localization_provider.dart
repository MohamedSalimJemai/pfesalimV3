import 'package:flutter/material.dart';
import 'package:pfe_salim/utils/language/localization_preference.dart';

class LocalizationProvider with ChangeNotifier {
  Locale _locale = const Locale("en");
  LocalizationPreference localizationPreference = LocalizationPreference();

  Locale get locale => _locale;

  set locale(Locale value) {
    _locale = value;
    localizationPreference.setLocalization(value.languageCode);
    notifyListeners();
  }
}
