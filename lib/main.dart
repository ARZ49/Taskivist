import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskivist/utilities/app_colors.dart';
import 'package:taskivist/views/main_screen.dart';

import 'views/start_screen.dart';

void main() {
  runApp(
    MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: const TextTheme(
      bodyLarge: TextStyle(fontFamily: 'Oswald',fontSize: 25,fontWeight: FontWeight.bold,color: AppColors.accentColor),
        bodySmall: TextStyle(fontFamily: 'Oswald',fontSize: 20,color: AppColors.accentColor,fontWeight: FontWeight.w400),
        bodyMedium: TextStyle(fontFamily: 'Oswald',fontSize: 22,fontWeight: FontWeight.w500,color: AppColors.accentColor),
       displayMedium: TextStyle(fontFamily: 'Oswald',fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white),

      )),
    ),
  );
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/start-page',
      builder: (BuildContext context, GoRouterState state) {
        return const StartPage();
      },
    ),
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MainPage();
      },
    ),
  ],
);
