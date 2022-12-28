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
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

import '../Authflow/auth_flow.dart' as _i1;
import '../pages/homepage.dart' as _i3;
import '../pages/itemlist.dart' as _i2;
import '../pages/loginpage.dart' as _i4;
import '../pages/user%20_navbar_item.dart' as _i5;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    AuthFlowRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.AuthFlowPage(),
      );
    },
    SelectionRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.SelectionPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.HomePage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.LoginPage(),
      );
    },
    NavigationRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.NavigationPage(),
      );
    },
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/auto',
          fullMatch: true,
        ),
        _i6.RouteConfig(
          AuthFlowRoute.name,
          path: '/auto',
          children: [
            _i6.RouteConfig(
              LoginRoute.name,
              path: 'login-page',
              parent: AuthFlowRoute.name,
            ),
            _i6.RouteConfig(
              NavigationRoute.name,
              path: 'navigation-page',
              parent: AuthFlowRoute.name,
            ),
          ],
        ),
        _i6.RouteConfig(
          SelectionRoute.name,
          path: '/selection-page',
        ),
        _i6.RouteConfig(
          HomeRoute.name,
          path: '/home-page',
        ),
      ];
}

/// generated route for
/// [_i1.AuthFlowPage]
class AuthFlowRoute extends _i6.PageRouteInfo<void> {
  const AuthFlowRoute({List<_i6.PageRouteInfo>? children})
      : super(
          AuthFlowRoute.name,
          path: '/auto',
          initialChildren: children,
        );

  static const String name = 'AuthFlowRoute';
}

/// generated route for
/// [_i2.SelectionPage]
class SelectionRoute extends _i6.PageRouteInfo<void> {
  const SelectionRoute()
      : super(
          SelectionRoute.name,
          path: '/selection-page',
        );

  static const String name = 'SelectionRoute';
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/home-page',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i4.LoginPage]
class LoginRoute extends _i6.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: 'login-page',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i5.NavigationPage]
class NavigationRoute extends _i6.PageRouteInfo<void> {
  const NavigationRoute()
      : super(
          NavigationRoute.name,
          path: 'navigation-page',
        );

  static const String name = 'NavigationRoute';
}
