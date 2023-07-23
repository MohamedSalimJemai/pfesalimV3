import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pfe_salim/utils/language/localization_provider.dart';
import 'package:pfe_salim/utils/theme/theme_provider.dart';
import 'package:pfe_salim/utils/theme/theme_styles.dart';
import 'package:pfe_salim/view/splash_screen.dart';
import 'package:pfe_salim/view/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();
  LocalizationProvider localizationProvider = LocalizationProvider();

  void loadThemeSettings() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  void loadLocalizationSettings() async {
    localizationProvider.locale = Locale(
      await localizationProvider.localizationPreference.getLocalization(),
    );
  }

  @override
  void initState() {
    super.initState();
    loadThemeSettings();
    loadLocalizationSettings();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => themeChangeProvider),
        ChangeNotifierProvider(create: (context) => localizationProvider),
      ],
      child: Consumer2<DarkThemeProvider, LocalizationProvider>(
        builder: (context, theme, locale, child) {
          return GlobalLoaderOverlay(
            closeOnBackButton: true,
            useDefaultLoading: false,
            overlayOpacity: 0.4,
            overlayWidget: const LoadingWidget(),
            overlayWholeScreen: true,
            child: MaterialApp(
              navigatorKey: navigatorKey,
              debugShowCheckedModeBanner: false,
              theme: Styles.themeData(themeChangeProvider.darkTheme, context),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: const [
                Locale('en', ''),
                Locale('fr', ''),
                Locale('de', ''),
              ],
              locale: locale.locale,
              home: const SplashScreen(),
            ),
          );
        },
      ),
    );
  }
}
