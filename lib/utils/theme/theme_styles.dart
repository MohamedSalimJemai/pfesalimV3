import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../dimensions.dart';

const Color accentColor = Color(0xff4975d2);
const Color secondaryAccentColor = Color(0xff2e4d8d);
const Color primaryColorSurfaceTint = Color(0xffd9dfe8);

const Color _successColorShade1 = Color(0xffcef6e2);
const Color _successColorShade1Dark = Color(0xff4d6458);
const Color successColorShade1Override = _successColorShade1;

const Color successColor = Color(0xff03cc5e);
const Color successColorAlt = Color(0xff04863f);

const Color dangerColorShade1 = Color(0xfffdd1d2);
const Color dangerColor = Color(0xFFF26666);
const Color dangerColorAlt = Color(0xFFAF4949);

const Color warningColorShade1 = Color(0xFFF8EABC);
const Color warningColor = Color(0xFFEFBE24);
const Color warningColorAlt = Color(0xFFAF8D1D);

const Color noticeColorShade1 = Color(0xFFBAECEF);
const Color noticeColor = Color(0xFF33CBD5);
const Color noticeColorAlt = Color(0xFF207B81);

const Color lightColor = Color(0xFFF7F7F7);
const Color darkColor = Color(0xFF181818);

class Styles {
  static late SystemUiOverlayStyle systemUiOverlayStyle;
  static late ColorScheme colorScheme;
  static late Color primaryColor;
  static late Color textColor;
  static late Color primaryBackgroundColor;
  static late Color backgroundColor;

  static late Color successColorShade1;

  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    primaryColor = isDarkTheme ? secondaryAccentColor : accentColor;
    textColor = isDarkTheme ? Colors.white : darkColor;
    backgroundColor = isDarkTheme ? Colors.black : lightColor;
    primaryBackgroundColor = isDarkTheme ? darkColor : Colors.white;

    successColorShade1 =
        isDarkTheme ? _successColorShade1Dark : _successColorShade1;

    systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarIconBrightness: isDarkTheme ? Brightness.light : Brightness.dark,
      statusBarColor: isDarkTheme ? Colors.transparent : Colors.transparent,
      systemNavigationBarColor: primaryBackgroundColor,
    );

    Future.delayed(const Duration(milliseconds: 1)).then(
      (value) => SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle),
    );

    colorScheme = ColorScheme(
      primary: primaryColor,
      onPrimary: Colors.white,
      onPrimaryContainer: Colors.white,
      secondary: primaryColor,
      onSecondary: backgroundColor,
      onSecondaryContainer: primaryColor,
      surface: primaryBackgroundColor,
      onSurface: textColor,
      background: backgroundColor,
      onBackground: textColor,
      onTertiaryContainer: textColor,
      error: dangerColor,
      onError: dangerColor,
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: colorScheme,
      indicatorColor: isDarkTheme ? primaryColor : primaryColor,
      hintColor: isDarkTheme ? Colors.grey[400] : Colors.grey[400],
      highlightColor: primaryColor.withOpacity(0.4),
      focusColor: isDarkTheme
          ? primaryColor.withOpacity(0.3)
          : primaryColor.withOpacity(0.3),
      disabledColor: Colors.grey,
      canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: isDarkTheme
            ? primaryColor.withOpacity(0.5)
            : primaryColor.withOpacity(0.5),
      ),
      dividerColor: Colors.transparent,

      /// WIDGETS -----------------------------------------------------------

      // APP BAR THEME
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: isDarkTheme ? lightColor : darkColor),
        actionsIconTheme: IconThemeData(
          color: isDarkTheme ? lightColor : darkColor,
        ),
        titleTextStyle: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        shape: Border(
          bottom: BorderSide(color: primaryColor, width: 1),
        ),
        centerTitle: true,
        elevation: 0,
      ),

      // BOTTOM NAVIGATION BAR THEME
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: backgroundColor,
      ),

      // TAB BAR THEME
      tabBarTheme: TabBarTheme(
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: primaryColor, width: 2.0),
          insets: const EdgeInsets.fromLTRB(80.0, 0.0, 80.0, 71.0),
        ),
        labelColor: primaryColor,
        labelStyle: const TextStyle(fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        unselectedLabelColor: Colors.grey,
      ),

      // CARD THEME
      cardTheme: CardTheme(
        color: primaryBackgroundColor,
        surfaceTintColor: Colors.transparent,
        margin: const EdgeInsets.all(0),
        shape: const RoundedRectangleBorder(
          borderRadius: Dimensions.roundedBorderBig,
        ),
      ),

      // TEXT FIELD THEME
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(8.0),
        filled: true,
        fillColor: isDarkTheme ? Colors.grey[900] : Colors.white,
        border: const OutlineInputBorder(
          borderRadius: Dimensions.roundedBorderMedium,
        ),
        hintStyle: const TextStyle(),
      ),

      // TEXT BUTTON THEME
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(primaryColor),
          foregroundColor: MaterialStatePropertyAll(backgroundColor),
          shape: const MaterialStatePropertyAll<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: Dimensions.roundedBorderMedium,
            ),
          ),
        ),
      ),

      // ELEVATED BUTTON THEME
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<OutlinedBorder>(
            const RoundedRectangleBorder(
              borderRadius: Dimensions.roundedBorderMedium,
            ),
          ),
        ),
      ),

      // FILLED BUTTON THEME
      filledButtonTheme: const FilledButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: Dimensions.roundedBorderMedium,
            ),
          ),
        ),
      ),

      // EXPANSION TILE THEME
      expansionTileTheme: ExpansionTileThemeData(
        textColor: textColor,
        iconColor: textColor,
      ),

      // SLIDER THEME
      sliderTheme: SliderThemeData(
        activeTrackColor: primaryColor,
        inactiveTrackColor: primaryColor.withOpacity(0.2),
      ),

      // SCROLLBAR THEME
      scrollbarTheme: ScrollbarThemeData(
        trackVisibility: const MaterialStatePropertyAll(true),
        thumbVisibility: const MaterialStatePropertyAll(true),
        thumbColor: MaterialStatePropertyAll(primaryColor),
      ),
    );
  }
}
