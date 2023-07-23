import 'package:flutter/material.dart';
import 'package:pfe_salim/view/admin/tabs/lines_tab_view.dart';
import 'package:pfe_salim/view/admin/tabs/statistics_tab_view.dart';
import 'package:pfe_salim/view/common_tabs/my_profile_tab_view.dart';

import '../../../utils/theme/theme_styles.dart';
import '../../../utils/user_session.dart';
import '../../utils/language/localization.dart';
import '../auth/login_view.dart';

class MainViewClient extends StatelessWidget {
  const MainViewClient({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(intl.clientSpace),
          actions: [
            IconButton(
              onPressed: () => UserSession.instance.resetUserSession().then(
                    (value) => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginView(),
                      ),
                      (Route<dynamic> route) => false,
                    ),
                  ),
              icon: const Icon(Icons.logout),
              color: dangerColor,
            )
          ],
        ),
        body: const TabBarView(
          children: [
            LinesTabView(),
            StatisticsTabView(),
            MyProfileTabView(),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Styles.primaryBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, -1),
                blurRadius: 10,
              )
            ],
          ),
          child: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(
                icon: const Icon(Icons.reorder),
                child: Text(
                  intl.lines,
                  overflow: TextOverflow.visible,
                  softWrap: false,
                ),
              ),
              Tab(
                icon: const Icon(Icons.area_chart_outlined),
                child: Text(
                  intl.statistics,
                  overflow: TextOverflow.visible,
                  softWrap: false,
                ),
              ),
              Tab(
                icon: const Icon(Icons.person),
                child: Text(
                  intl.myProfile,
                  overflow: TextOverflow.visible,
                  softWrap: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
