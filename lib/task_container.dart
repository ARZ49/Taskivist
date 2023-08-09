import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:taskivist/utilities/app_colors.dart';

class TaskContainer extends StatelessWidget {
  const TaskContainer({
    super.key,
    this.isCompleted = false,
    required this.onTap,
    required this.title,
    required this.description,
    required this.date,
    required this.onLongPress,
  });
  final bool isCompleted;
  final VoidCallback onTap;
  final String title;
  final String description;
  final String date;
  final VoidCallback onLongPress;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                backgroundColor: AppColors.primaryColor,
                content: SizedBox(
                  height: 110,
                  width: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Edit',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(200, 45),
                            backgroundColor: AppColors.secondaryColor),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ElevatedButton(
                        onPressed: onLongPress,
                        child: Text(
                          'Delete',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(200, 45),
                            backgroundColor: AppColors.secondaryColor),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: Text(
                        'Close',
                        style: Theme.of(context).textTheme.bodySmall,
                      ))
                ],
              );
            });
      },
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        height: 115,
        decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                isCompleted
                    ? Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: SvgPicture.asset(
                              'assets/icons/done.svg',
                              height: 25,
                              width: 25,
                            ),
                          ),
                          SizedBox(
                            width: 150,
                            child: Text(
                              // 'Project Due',
                              title,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium,
                          
                            ),
                          ),
                        ],
                      )
                    : SizedBox(
                      width: 250,
                      child: Text(
                          // 'Project Due',
                          title,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                    ),
                Text(
                  // 'Date: 10/7/2023',
                  date,
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ],
            ),
            Text(
              // 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
              description,

              style: Theme.of(context).textTheme.displayMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            )
          ],
        ),
      ),
    );
  }
}
