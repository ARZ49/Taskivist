import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskivist/utilities/app_colors.dart';
import 'package:taskivist/views/completed_task_screen.dart';
import 'package:taskivist/views/pending_task_screen.dart';
import 'package:taskivist/views/task_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int bottomNavIndex = 1;
  List screens = [
    const PendingTaskScreen(),
    TaskScreen(),
    const CompletedTaskScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Theme(
        data: ThemeData(
            iconTheme: const IconThemeData(color: AppColors.accentColor)),
        child: CurvedNavigationBar(
          height: 70,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 600),
          letIndexChange: (index) => true,
          items: [
            CurvedNavigationBarItem(
              child: SvgPicture.asset(
                'assets/icons/pending.svg',
                height: 40,
                width: 40,
              ),
            ),
            CurvedNavigationBarItem(
              child: SvgPicture.asset(
                'assets/icons/view_all.svg',
                height: 45,
                width: 45,
              ),
            ),
            CurvedNavigationBarItem(
              child: SvgPicture.asset(
                'assets/icons/completed.svg',
                height: 50,
                width: 50,
              ),
            )
          ],
          index: bottomNavIndex,
          onTap: (value) => setState(() {
            bottomNavIndex = value;
          }),
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: AppColors.secondaryColor,
          color: AppColors.primaryColor,
        ),
      ),
      body: screens[bottomNavIndex],
    );
  }
}
