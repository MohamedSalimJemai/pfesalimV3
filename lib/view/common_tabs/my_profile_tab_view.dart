import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/dimensions.dart';
import '../../utils/language/localization.dart';
import '../../utils/theme/theme_provider.dart';
import '../../utils/theme/theme_styles.dart';
import '../../utils/user_session.dart';
import '../admin/views/language_view.dart';
import '../auth/login_view.dart';
import '../splash_screen.dart';
import '../widgets/api_image_widget.dart';

class MyProfileTabView extends StatelessWidget {
  const MyProfileTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();

    DarkThemeProvider darkThemeProvider =
        Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      body: Scrollbar(
        controller: scrollController,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Center(
            child: Container(
              margin: Dimensions.bigMargin,
              width: double.infinity,
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: Dimensions.bigPadding,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Styles.primaryColor.withOpacity(0.1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ApiImageWidget(
                          width: 90,
                          height: 90,
                          imageFilename: UserSession.currentUser?.imageFilename,
                          isCircular: true,
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: SizedBox(
                            height: 90,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${intl.doubleDotPlaceholder(intl.firstname)} "
                                  "${UserSession.currentUser?.firstname}",
                                  style: TextStyle(color: Styles.primaryColor),
                                ),
                                Text(
                                  "${intl.doubleDotPlaceholder(intl.lastname)} "
                                  "${UserSession.currentUser?.lastname}",
                                  style: TextStyle(color: Styles.primaryColor),
                                ),
                                Text(
                                  "${intl.doubleDotPlaceholder(intl.email)} "
                                  "${UserSession.currentUser?.email}",
                                  style: TextStyle(color: Styles.primaryColor),
                                ),
                                Text(
                                  "${intl.doubleDotPlaceholder(intl.role)} "
                                  "${UserSession.currentUser?.roles.first.name}",
                                  style: TextStyle(color: Styles.primaryColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildSettingWidget(
                    icon: Icons.language,
                    title: intl.language,
                    action: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LanguageView(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildSettingWidget(
                    icon: darkThemeProvider.darkTheme
                        ? Icons.light_mode
                        : Icons.dark_mode,
                    title: darkThemeProvider.darkTheme
                        ? intl.lightMode
                        : intl.darkMode,
                    action: () {
                      darkThemeProvider.darkTheme =
                          !darkThemeProvider.darkTheme;
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SplashScreen(),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildSettingWidget(
                    icon: Icons.logout,
                    title: intl.logout,
                    action: () => UserSession.instance.resetUserSession().then(
                          (value) => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginView(),
                            ),
                            (Route<dynamic> route) => false,
                          ),
                        ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingWidget({
    required IconData icon,
    required String title,
    required void Function() action,
  }) {
    return ElevatedButton(
      onPressed: action,
      style: ButtonStyle(
        surfaceTintColor: const MaterialStatePropertyAll(Colors.transparent),
        overlayColor: MaterialStatePropertyAll(
          Styles.primaryColor.withOpacity(0.2),
        ),
        backgroundColor: MaterialStatePropertyAll(
          Styles.primaryBackgroundColor,
        ),
        foregroundColor: MaterialStatePropertyAll(
          Styles.textColor,
        ),
        padding: const MaterialStatePropertyAll(EdgeInsets.zero),
      ),
      child: SizedBox(
        height: 60,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Styles.primaryColor.withOpacity(0.3),
                    ),
                    child: Icon(icon, color: Styles.primaryColor),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey.shade400,
              size: 18,
            ),
            const SizedBox(width: 15)
          ],
        ),
      ),
    );
  }
}
