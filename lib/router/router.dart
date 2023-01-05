import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:moneylover/Authflow/auth_flow.dart';
import 'package:moneylover/pages/account.dart';
import 'package:moneylover/pages/amount.dart';
import 'package:moneylover/pages/detailpage.dart';
import 'package:moneylover/pages/homepage.dart';
import 'package:moneylover/pages/loginpage.dart';
import 'package:moneylover/pages/itemlist.dart';
import 'package:moneylover/pages/planning.dart';
import 'package:moneylover/pages/report.dart';
import 'package:moneylover/pages/transaction.dart';
import 'package:moneylover/pages/user%20_navbar_item.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(page: AuthFlowPage, initial: true, path: '/auto', children: [
      AutoRoute(
        path: '',
        page: LoginPage,
      ),
      groupTabRouter
    ]),
    AutoRoute(
      page: SelectionPage,
    ),
    AutoRoute(
      page: DetailPage,
    ),
  ],
)
class $AppRouter {}

const groupTabRouter = AutoRoute(
  path: 'group/:id',
  page: NavigationPage,
  children: [
    AutoRoute(
      path: 'tab1',
      name: 'GroupTab1Router',
      page: EmptyRouterPage,
      children: [
        AutoRoute(path: '', page: HomePage, children: [
          AutoRoute(
            path: 'tab6',
            name: 'GroupTab6Router',
            page: EmptyRouterPage,
            children: [
              AutoRoute(
                path: '',
                page: ReportPage,
              ),
              RedirectRoute(path: '*', redirectTo: ''),
            ],
          ),
        ]),
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),
    AutoRoute(
      path: 'tab2',
      name: 'GroupTab2Router',
      page: EmptyRouterPage,
      children: [
        AutoRoute(path: '', page: TransactionPage),
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),
    AutoRoute(
      path: 'tab3',
      name: 'GroupTab3Router',
      page: EmptyRouterPage,
      children: [
        AutoRoute(path: '', page: AmountPage),
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),
    AutoRoute(
      path: 'tab4',
      name: 'GroupTab4Router',
      page: EmptyRouterPage,
      children: [
        AutoRoute(path: '', page: PlanningPage),
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),
    AutoRoute(
      path: 'tab5',
      name: 'GroupTab5Router',
      page: EmptyRouterPage,
      children: [
        AutoRoute(path: '', page: AccountPage),
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),
  ],
);
