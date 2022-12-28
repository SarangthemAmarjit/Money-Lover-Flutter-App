import 'package:auto_route/auto_route.dart';
import 'package:moneylover/Authflow/auth_flow.dart';
import 'package:moneylover/pages/homepage.dart';
import 'package:moneylover/pages/loginpage.dart';
import 'package:moneylover/pages/itemlist.dart';
import 'package:moneylover/pages/user%20_navbar_item.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(page: AuthFlowPage, initial: true, path: '/auto', children: [
      AutoRoute(
        page: LoginPage,
      ),
      AutoRoute(
        page: NavigationPage,
      ),
    ]),
    AutoRoute(
      page: SelectionPage,
    ),
    AutoRoute(
      page: HomePage,
    ),
  ],
)
class $AppRouter {}
