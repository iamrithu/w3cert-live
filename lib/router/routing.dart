// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:w3cert/router/routing-const.dart';
import 'package:w3cert/screens/attendence/attendence.dart';
import 'package:w3cert/screens/task/task.dart';

import '../provider/providers.dart';
import '../screens/dashboard/dashboard.dart';
import '../screens/notification/notification.dart';

import '../screens/employee/employee.dart';
import '../screens/login/login.dart';

final _navigatorKey = GlobalKey<NavigatorState>();
GoRouter? _previousRouter;

final goRouterProvider = Provider<GoRouter>(
  ((ref) {
    final loggedIn = ref.watch(loggedInProvider);

    final router = RouterNotifier(ref);
    return GoRouter(
      initialLocation: _previousRouter?.location,
      navigatorKey: _navigatorKey,
      routes: router._router,
      redirect: (context, state) async {
        final loggingIn = state.location == '/login';
        if (!loggedIn) {
          if (!loggingIn) return '/login';
          return null;
        }

        if (loggingIn) return '/';
        return null;
      },
    );
  }),
);

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;
  RouterNotifier(this._ref);

  List<GoRoute> get _router => [
        GoRoute(
          name: RoutingConstants.dashboard,
          path: '/',
          pageBuilder: (context, state) {
            return const MaterialPage(
              child: Dashboard(),
            );
          },
        ),
        GoRoute(
          name: RoutingConstants.login,
          path: '/login',
          pageBuilder: (context, state) {
            return const MaterialPage(
              child: Login(),
            );
          },
        ),
        GoRoute(
          name: RoutingConstants.employee,
          path: '/employee',
          pageBuilder: (context, state) {
            return const MaterialPage(
              child: Employee(),
            );
          },
        ),
        GoRoute(
          name: RoutingConstants.attendence,
          path: '/attendence',
          pageBuilder: (context, state) {
            return const MaterialPage(
              child: Attendence(),
            );
          },
        ),
        GoRoute(
          name: RoutingConstants.notifications,
          path: '/notifications',
          pageBuilder: (context, state) {
            return const MaterialPage(
              child: NotificationScreen(),
            );
          },
        ),
        GoRoute(
          name: RoutingConstants.task,
          path: '/task',
          pageBuilder: (context, state) {
            return const MaterialPage(
              child: Tasks(),
            );
          },
        ),
      ];
}
