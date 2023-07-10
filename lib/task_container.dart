import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskivist/utilities/app_colors.dart';

class TaskContainer extends StatelessWidget {
  const TaskContainer({super.key,this.isCompleted = false});
final bool isCompleted;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
      height: 115,
      decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isCompleted? Row(children: [
                  Text(
                'Project Due',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: SvgPicture.asset('assets/icons/done.svg',height: 25,width: 25,),
              )
              ],):
              Text(
                'Project Due',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                'Date: 10/7/2023',
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          ),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
            style: Theme.of(context).textTheme.displayMedium,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          )
        ],
      ),
    );
  }
}
