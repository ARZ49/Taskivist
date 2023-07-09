
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskivist/utilities/app_colors.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
                top: -30,
                left: -30,
                child: CircleAvatar(
                  backgroundColor: AppColors.primaryColor.withOpacity(0.8),
                  radius: 85,
                )),
            Positioned(
                top: -60,
                left: 70,
                child: CircleAvatar(
                  backgroundColor: AppColors.primaryColor.withOpacity(0.8),
                  radius: 90,
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 150,
                ),
                Image.asset(
                  'assets/images/task.png',
                  height: 320,
                  width: 400,
                ),
                const SizedBox(
                  height: 25,
                ),
                const SizedBox(
                  width: 355,
                  child: Text(
                    '“Not only should you have a to-do list, but it must become your best friend.” — Jim Kwik"',
                    style: TextStyle(
                        fontSize: 25,
                        color: AppColors.secondaryColor,
                        fontWeight: FontWeight.w400),
                    maxLines: 3,
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                ElevatedButton(
                  onPressed: () {
                    context.go('/main-page');
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      fixedSize: const Size(220, 55),
                      foregroundColor: AppColors.secondaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Text(
                    "Let's Get Started",
                    style: TextStyle(
                        color: AppColors.accentColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
