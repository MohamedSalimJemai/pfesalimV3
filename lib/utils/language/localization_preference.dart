import 'package:shared_preferences/shared_preferences.dart';

class LocalizationPreference {
  static const savedLocalization = "SAVED_LOCALIZATION";

  setLocalization(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(savedLocalization, value);
  }

  Future<String> getLocalization() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(savedLocalization) ?? "en";
  }
}
