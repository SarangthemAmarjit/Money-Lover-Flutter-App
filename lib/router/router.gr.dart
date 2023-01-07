// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i13;
import 'package:auto_route/empty_router_widgets.dart' as _i6;
import 'package:flutter/material.dart' as _i14;

import '../Authflow/auth_flow.dart' as _i1;
import '../pages/account.dart' as _i12;
import '../pages/amount.dart' as _i10;
import '../pages/detailpage.dart' as _i3;
import '../pages/homepage.dart' as _i7;
import '../pages/itemlist.dart' as _i2;
import '../pages/loginpage.dart' as _i4;
import '../pages/planning.dart' as _i11;
import '../pages/report.dart' as _i8;
import '../pages/transaction.dart' as _i9;
import '../pages/user%20_navbar_item.dart' as _i5;

class AppRouter extends _i13.RootStackRouter {
  AppRouter([_i14.GlobalKey<_i14.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i13.PageFactory> pagesMap = {
    AuthFlowRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.AuthFlowPage(),
      );
    },
    SelectionRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.SelectionPage(),
      );
    },
    DetailRoute.name: (routeData) {
      final args = routeData.argsAs<DetailRouteArgs>();
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.DetailPage(
          key: args.key,
          categoryname: args.categoryname,
          amount: args.amount,
          date: args.date,
          transactionid: args.transactionid,
          categoryid: args.categoryid,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.LoginPage(),
      );
    },
    NavigationRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.NavigationPage(),
      );
    },
    GroupTab1Router.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.EmptyRouterPage(),
      );
    },
    GroupTab2Router.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.EmptyRouterPage(),
      );
    },
    GroupTab3Router.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.EmptyRouterPage(),
      );
    },
    GroupTab4Router.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.EmptyRouterPage(),
      );
    },
    GroupTab5Router.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.EmptyRouterPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.HomePage(),
      );
    },
    GroupTab6Router.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.EmptyRouterPage(),
      );
    },
    ReportRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.ReportPage(),
      );
    },
    TransactionRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i9.TransactionPage(),
      );
    },
    AmountRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i10.AmountPage(),
      );
    },
    PlanningRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i11.PlanningPage(),
      );
    },
    AccountRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i12.AccountPage(),
      );
    },
  };

  @override
  List<_i13.RouteConfig> get routes => [
        _i13.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/auto',
          fullMatch: true,
        ),
        _i13.RouteConfig(
          AuthFlowRoute.name,
          path: '/auto',
          children: [
            _i13.RouteConfig(
              LoginRoute.name,
              path: '',
              parent: AuthFlowRoute.name,
            ),
            _i13.RouteConfig(
              NavigationRoute.name,
              path: 'group/:id',
              parent: AuthFlowRoute.name,
              children: [
                _i13.RouteConfig(
                  GroupTab1Router.name,
                  path: 'tab1',
                  parent: NavigationRoute.name,
                  children: [
                    _i13.RouteConfig(
                      HomeRoute.name,
                      path: '',
                      parent: GroupTab1Router.name,
                      children: [
                        _i13.RouteConfig(
                          GroupTab6Router.name,
                          path: 'tab6',
                          parent: HomeRoute.name,
                          children: [
                            _i13.RouteConfig(
                              ReportRoute.name,
                              path: '',
                              parent: GroupTab6Router.name,
                            ),
                            _i13.RouteConfig(
                              '*#redirect',
                              path: '*',
                              parent: GroupTab6Router.name,
                              redirectTo: '',
                              fullMatch: true,
                            ),
                          ],
                        )
                      ],
                    ),
                    _i13.RouteConfig(
                      '*#redirect',
                      path: '*',
                      parent: GroupTab1Router.name,
                      redirectTo: '',
                      fullMatch: true,
                    ),
                  ],
                ),
                _i13.RouteConfig(
                  GroupTab2Router.name,
                  path: 'tab2',
                  parent: NavigationRoute.name,
                  children: [
                    _i13.RouteConfig(
                      TransactionRoute.name,
                      path: '',
                      parent: GroupTab2Router.name,
                    ),
                    _i13.RouteConfig(
                      '*#redirect',
                      path: '*',
                      parent: GroupTab2Router.name,
                      redirectTo: '',
                      fullMatch: true,
                    ),
                  ],
                ),
                _i13.RouteConfig(
                  GroupTab3Router.name,
                  path: 'tab3',
                  parent: NavigationRoute.name,
                  children: [
                    _i13.RouteConfig(
                      AmountRoute.name,
                      path: '',
                      parent: GroupTab3Router.name,
                    ),
                    _i13.RouteConfig(
                      '*#redirect',
                      path: '*',
                      parent: GroupTab3Router.name,
                      redirectTo: '',
                      fullMatch: true,
                    ),
                  ],
                ),
                _i13.RouteConfig(
                  GroupTab4Router.name,
                  path: 'tab4',
                  parent: NavigationRoute.name,
                  children: [
                    _i13.RouteConfig(
                      PlanningRoute.name,
                      path: '',
                      parent: GroupTab4Router.name,
                    ),
                    _i13.RouteConfig(
                      '*#redirect',
                      path: '*',
                      parent: GroupTab4Router.name,
                      redirectTo: '',
                      fullMatch: true,
                    ),
                  ],
                ),
                _i13.RouteConfig(
                  GroupTab5Router.name,
                  path: 'tab5',
                  parent: NavigationRoute.name,
                  children: [
                    _i13.RouteConfig(
                      AccountRoute.name,
                      path: '',
                      parent: GroupTab5Router.name,
                    ),
                    _i13.RouteConfig(
                      '*#redirect',
                      path: '*',
                      parent: GroupTab5Router.name,
                      redirectTo: '',
                      fullMatch: true,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        _i13.RouteConfig(
          SelectionRoute.name,
          path: '/selection-page',
        ),
        _i13.RouteConfig(
          DetailRoute.name,
          path: '/detail-page',
        ),
      ];
}

/// generated route for
/// [_i1.AuthFlowPage]
class AuthFlowRoute extends _i13.PageRouteInfo<void> {
  const AuthFlowRoute({List<_i13.PageRouteInfo>? children})
      : super(
          AuthFlowRoute.name,
          path: '/auto',
          initialChildren: children,
        );

  static const String name = 'AuthFlowRoute';
}

/// generated route for
/// [_i2.SelectionPage]
class SelectionRoute extends _i13.PageRouteInfo<void> {
  const SelectionRoute()
      : super(
          SelectionRoute.name,
          path: '/selection-page',
        );

  static const String name = 'SelectionRoute';
}

/// generated route for
/// [_i3.DetailPage]
class DetailRoute extends _i13.PageRouteInfo<DetailRouteArgs> {
  DetailRoute({
    _i14.Key? key,
    required String categoryname,
    required int amount,
    required DateTime date,
    required String transactionid,
    required String categoryid,
  }) : super(
          DetailRoute.name,
          path: '/detail-page',
          args: DetailRouteArgs(
            key: key,
            categoryname: categoryname,
            amount: amount,
            date: date,
            transactionid: transactionid,
            categoryid: categoryid,
          ),
        );

  static const String name = 'DetailRoute';
}

class DetailRouteArgs {
  const DetailRouteArgs({
    this.key,
    required this.categoryname,
    required this.amount,
    required this.date,
    required this.transactionid,
    required this.categoryid,
  });

  final _i14.Key? key;

  final String categoryname;

  final int amount;

  final DateTime date;

  final String transactionid;

  final String categoryid;

  @override
  String toString() {
    return 'DetailRouteArgs{key: $key, categoryname: $categoryname, amount: $amount, date: $date, transactionid: $transactionid, categoryid: $categoryid}';
  }
}

/// generated route for
/// [_i4.LoginPage]
class LoginRoute extends _i13.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i5.NavigationPage]
class NavigationRoute extends _i13.PageRouteInfo<void> {
  const NavigationRoute({List<_i13.PageRouteInfo>? children})
      : super(
          NavigationRoute.name,
          path: 'group/:id',
          initialChildren: children,
        );

  static const String name = 'NavigationRoute';
}

/// generated route for
/// [_i6.EmptyRouterPage]
class GroupTab1Router extends _i13.PageRouteInfo<void> {
  const GroupTab1Router({List<_i13.PageRouteInfo>? children})
      : super(
          GroupTab1Router.name,
          path: 'tab1',
          initialChildren: children,
        );

  static const String name = 'GroupTab1Router';
}

/// generated route for
/// [_i6.EmptyRouterPage]
class GroupTab2Router extends _i13.PageRouteInfo<void> {
  const GroupTab2Router({List<_i13.PageRouteInfo>? children})
      : super(
          GroupTab2Router.name,
          path: 'tab2',
          initialChildren: children,
        );

  static const String name = 'GroupTab2Router';
}

/// generated route for
/// [_i6.EmptyRouterPage]
class GroupTab3Router extends _i13.PageRouteInfo<void> {
  const GroupTab3Router({List<_i13.PageRouteInfo>? children})
      : super(
          GroupTab3Router.name,
          path: 'tab3',
          initialChildren: children,
        );

  static const String name = 'GroupTab3Router';
}

/// generated route for
/// [_i6.EmptyRouterPage]
class GroupTab4Router extends _i13.PageRouteInfo<void> {
  const GroupTab4Router({List<_i13.PageRouteInfo>? children})
      : super(
          GroupTab4Router.name,
          path: 'tab4',
          initialChildren: children,
        );

  static const String name = 'GroupTab4Router';
}

/// generated route for
/// [_i6.EmptyRouterPage]
class GroupTab5Router extends _i13.PageRouteInfo<void> {
  const GroupTab5Router({List<_i13.PageRouteInfo>? children})
      : super(
          GroupTab5Router.name,
          path: 'tab5',
          initialChildren: children,
        );

  static const String name = 'GroupTab5Router';
}

/// generated route for
/// [_i7.HomePage]
class HomeRoute extends _i13.PageRouteInfo<void> {
  const HomeRoute({List<_i13.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          path: '',
          initialChildren: children,
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i6.EmptyRouterPage]
class GroupTab6Router extends _i13.PageRouteInfo<void> {
  const GroupTab6Router({List<_i13.PageRouteInfo>? children})
      : super(
          GroupTab6Router.name,
          path: 'tab6',
          initialChildren: children,
        );

  static const String name = 'GroupTab6Router';
}

/// generated route for
/// [_i8.ReportPage]
class ReportRoute extends _i13.PageRouteInfo<void> {
  const ReportRoute()
      : super(
          ReportRoute.name,
          path: '',
        );

  static const String name = 'ReportRoute';
}

/// generated route for
/// [_i9.TransactionPage]
class TransactionRoute extends _i13.PageRouteInfo<void> {
  const TransactionRoute()
      : super(
          TransactionRoute.name,
          path: '',
        );

  static const String name = 'TransactionRoute';
}

/// generated route for
/// [_i10.AmountPage]
class AmountRoute extends _i13.PageRouteInfo<void> {
  const AmountRoute()
      : super(
          AmountRoute.name,
          path: '',
        );

  static const String name = 'AmountRoute';
}

/// generated route for
/// [_i11.PlanningPage]
class PlanningRoute extends _i13.PageRouteInfo<void> {
  const PlanningRoute()
      : super(
          PlanningRoute.name,
          path: '',
        );

  static const String name = 'PlanningRoute';
}

/// generated route for
/// [_i12.AccountPage]
class AccountRoute extends _i13.PageRouteInfo<void> {
  const AccountRoute()
      : super(
          AccountRoute.name,
          path: '',
        );

  static const String name = 'AccountRoute';
}
