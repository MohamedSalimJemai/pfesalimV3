import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pfe_salim/view/client/main_view_client.dart';
import 'package:pfe_salim/view/widgets/loading_widget.dart';

import '../model/enums/role.dart';
import '../utils/language/localization.dart';
import '../utils/user_session.dart';
import 'admin/main_view_admin.dart';
import 'auth/login_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Future<bool> checkSessionFuture;

  Future<void> initializeMainPage() async {
    await Future.delayed(const Duration(milliseconds: 200)).then((value) {
      intl = AppLocalizations.of(context) as AppLocalizations;
    });

    await UserSession.instance.loadUserSession().whenComplete(() async {
      if (UserSession.currentUser == null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginView()),
          (Route<dynamic> route) => false,
        );
      } else {
        await UserSession.instance.refreshUserSession().whenComplete(() {
          if (UserSession.currentUser!.roles.contains(Role.admin)) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MainViewAdmin()),
              (Route<dynamic> route) => false,
            );
          } else {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MainViewClient()),
              (Route<dynamic> route) => false,
            );
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    initializeMainPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', width: 200, height: 200),
            const SizedBox(height: 30),
            const LoadingWidget()
          ],
        ),
      ),
    );
  }
}
