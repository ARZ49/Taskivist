import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:taskivist/utilities/app_colors.dart';
import 'package:taskivist/views/task_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int bottomNavIndex = 1;
  List screens = [
    TaskScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      bottomNavigationBar: Theme(
        data: ThemeData(iconTheme: IconThemeData(color: AppColors.accentColor)),
        child: CurvedNavigationBar(
          items: const [
            Icon(Icons.pending),
            Icon(Icons.menu),
            Icon(Icons.done),
          ],
          index: bottomNavIndex,
          onTap: (value) => setState(() {
            bottomNavIndex = value;
          }),
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: AppColors.secondaryColor,
          color: AppColors.primaryColor,
          animationCurve: Curves.easeInOut,
        ),
      ),
     
    );
  }
}
