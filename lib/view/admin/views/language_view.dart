import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/dimensions.dart';
import '../../../utils/language/localization.dart';
import '../../../utils/language/localization_provider.dart';
import '../../splash_screen.dart';

class LanguageView extends StatelessWidget {
  const LanguageView({Key? key}) : super(key: key);

  void changeLanguage(BuildContext context, String languageCode) {
    Provider.of<LocalizationProvider>(context, listen: false).locale =
        Locale(languageCode);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SplashScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(intl.language)),
      body: Padding(
        padding: Dimensions.bigPadding,
        child: Column(
          children: [
            buildLanguageItem(
              context: context,
              languageName: "English",
              languageCode: "en",
              countryName: "United States",
              countryCode: 'US',
            ),
            Divider(height: 1, color: Colors.grey.shade500.withOpacity(0.5)),
            buildLanguageItem(
              context: context,
              languageName: "Français",
              languageCode: "fr",
              countryName: "France",
              countryCode: "FR",
            ),
            Divider(height: 1, color: Colors.grey.shade500.withOpacity(0.5)),
            buildLanguageItem(
              context: context,
              languageName: "Deutsch",
              languageCode: "de",
              countryName: "Deutschland",
              countryCode: "DE",
            ),
            Divider(height: 1, color: Colors.grey.shade500.withOpacity(0.5)),
          ],
        ),
      ),
    );
  }

  Widget buildLanguageItem({
    required BuildContext context,
    required String languageName,
    required String languageCode,
    required String countryName,
    required String countryCode,
  }) {
    return InkWell(
      onTap: () => changeLanguage(context, languageCode),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Flag.fromString(
              countryCode,
              borderRadius: Dimensions.radiusMedium,
              height: 60,
              width: 60 * 4 / 3,
              fit: BoxFit.fill,
            ),
            const SizedBox(width: 30),
            Expanded(
              child: Row(
                children: [
                  Text(languageName),
                  const SizedBox(width: 8),
                  Text("($countryName)"),
                ],
              ),
            ),
            if (Provider.of<LocalizationProvider>(context).locale ==
                Locale(languageCode))
              const Icon(Icons.check)
          ],
        ),
      ),
    );
  }
}
