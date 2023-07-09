import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskivist/views/main_screen.dart';

import 'views/start_screen.dart';

void main() {
  runApp(
    MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    ),
  );
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const StartPage();
      },
    ),
    GoRoute(
      path: '/main-page',
      builder: (BuildContext context, GoRouterState state) {
        return const MainPage();
      },
    ),
  ],
);
