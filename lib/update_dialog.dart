import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskivist/utilities/app_colors.dart';

class UpdateDialog extends StatelessWidget {
  const UpdateDialog(
      {super.key,
      required this.editingController,
      required this.hintText,
      required this.title,
      required this.onPressed});
  final TextEditingController editingController;
  final String hintText;
  final String title;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: AppColors.primaryColor,
      title: Text(
        'Edit title',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      content: SizedBox(
        height: 110,
        width: 100,
        child: TextField(
          controller: editingController,
          cursorColor: AppColors.accentColor,
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: InputDecoration(
              fillColor: AppColors.secondaryColor,
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              hintText: hintText,
              hintStyle: Theme.of(context).textTheme.bodySmall),
        ),
      ),
      actions: [
        TextButton(
            onPressed: onPressed,
            child: Text(
              'Save',
              style: Theme.of(context).textTheme.bodySmall,
            )),
        TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text(
              'Close',
              style: Theme.of(context).textTheme.bodySmall,
            )),
      ],
    );
  }
}
