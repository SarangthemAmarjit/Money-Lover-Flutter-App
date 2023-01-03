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
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;

import '../Authflow/auth_flow.dart' as _i1;
import '../pages/homepage.dart' as _i3;
import '../pages/itemlist.dart' as _i2;
import '../pages/loginpage.dart' as _i4;
import '../pages/transaction.dart' as _i6;
import '../pages/user%20_navbar_item.dart' as _i5;

class AppRouter extends _i7.RootStackRouter {
  AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    AuthFlowRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.AuthFlowPage(),
      );
    },
    SelectionRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.SelectionPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.HomePage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.LoginPage(),
      );
    },
    NavigationRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.NavigationPage(),
      );
    },
    TransactionRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.TransactionPage(),
      );
    },
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/auto',
          fullMatch: true,
        ),
        _i7.RouteConfig(
          AuthFlowRoute.name,
          path: '/auto',
          children: [
            _i7.RouteConfig(
              LoginRoute.name,
              path: 'login-page',
              parent: AuthFlowRoute.name,
            ),
            _i7.RouteConfig(
              NavigationRoute.name,
              path: 'navigation-page',
              parent: AuthFlowRoute.name,
              children: [
                _i7.RouteConfig(
                  TransactionRoute.name,
                  path: 'transaction-page',
                  parent: NavigationRoute.name,
                )
              ],
            ),
          ],
        ),
        _i7.RouteConfig(
          SelectionRoute.name,
          path: '/selection-page',
        ),
        _i7.RouteConfig(
          HomeRoute.name,
          path: '/home-page',
        ),
      ];
}

/// generated route for
/// [_i1.AuthFlowPage]
class AuthFlowRoute extends _i7.PageRouteInfo<void> {
  const AuthFlowRoute({List<_i7.PageRouteInfo>? children})
      : super(
          AuthFlowRoute.name,
          path: '/auto',
          initialChildren: children,
        );

  static const String name = 'AuthFlowRoute';
}

/// generated route for
/// [_i2.SelectionPage]
class SelectionRoute extends _i7.PageRouteInfo<void> {
  const SelectionRoute()
      : super(
          SelectionRoute.name,
          path: '/selection-page',
        );

  static const String name = 'SelectionRoute';
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/home-page',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i4.LoginPage]
class LoginRoute extends _i7.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: 'login-page',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i5.NavigationPage]
class NavigationRoute extends _i7.PageRouteInfo<void> {
  const NavigationRoute({List<_i7.PageRouteInfo>? children})
      : super(
          NavigationRoute.name,
          path: 'navigation-page',
          initialChildren: children,
        );

  static const String name = 'NavigationRoute';
}

/// generated route for
/// [_i6.TransactionPage]
class TransactionRoute extends _i7.PageRouteInfo<void> {
  const TransactionRoute()
      : super(
          TransactionRoute.name,
          path: 'transaction-page',
        );

  static const String name = 'TransactionRoute';
}
