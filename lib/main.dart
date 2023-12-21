import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:taskivist/controller/controller.dart';
import 'package:taskivist/utilities/app_colors.dart';
import 'package:taskivist/views/add_task_screen.dart';
import 'package:taskivist/views/main_screen.dart';
import 'package:taskivist/views/pending_task_screen.dart';
import 'package:taskivist/views/start_screen.dart';
import 'package:taskivist/views/task_detail_screen.dart';

import 'controller/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (context) => Controller(),
      child: MaterialApp.router(
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            textTheme: const TextTheme(
          bodyLarge: TextStyle(
              fontFamily: 'Oswald',
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: AppColors.accentColor),
          bodySmall: TextStyle(
              fontFamily: 'Oswald',
              fontSize: 20,
              color: AppColors.accentColor,
              fontWeight: FontWeight.w400),
          bodyMedium: TextStyle(
              fontFamily: 'Oswald',
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: AppColors.accentColor),
          displayMedium: TextStyle(
              fontFamily: 'Oswald',
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white),
        )),
      ),
    ),
  );
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return FutureBuilder<bool>(
            future: DataBaseHelper().checkIfDatabaseExists(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data == true) {
                  return const MainPage();
                } else {
                  return const StartPage();
                }
              }
              return const Scaffold(body: Center(child: CircularProgressIndicator()));
            });
      },
    ),
    GoRoute(
      path: '/main-page',
      builder: (BuildContext context, GoRouterState state) {
        return const MainPage();
      },
    ),
    GoRoute(
      path: '/task-detail-screen',
      builder: (BuildContext context, GoRouterState state) {
        return TaskDetailScreen(
          snapshot: state.extra,
        );
      },
    ),
    GoRoute(
      path: '/Add-Task-Screen',
      builder: (BuildContext context, GoRouterState state) {
        return const AddTaskScreen();
      },
    ),
      GoRoute(
      path: '/Pending-Page',
      builder: (BuildContext context, GoRouterState state) {
        return const PendingTaskScreen();
      },
    ),
  ],
);
