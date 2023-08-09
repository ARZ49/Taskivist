import 'package:flutter/material.dart';
import 'package:taskivist/utilities/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key,required this.onPressed});
 final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return   Padding(
               padding: const EdgeInsets.all(8.0),
               child: ElevatedButton(
                      onPressed: onPressed,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          fixedSize: const Size(375, 55),
                          foregroundColor: AppColors.secondaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: const Text(
                        "Add Task",
                        style: TextStyle(
                            color: AppColors.accentColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
             );
  }
}