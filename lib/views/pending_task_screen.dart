import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskivist/custom_app_bar.dart';
import 'package:taskivist/utilities/app_colors.dart';

import '../task_container.dart';

class PendingTaskScreen extends StatelessWidget {
  const PendingTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: CustomScrollView(slivers: [
        const CustomAppBar(),
         SliverList(
                delegate: SliverChildListDelegate([
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pending',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          decoration: TextDecoration.underline,
                          decorationStyle: TextDecorationStyle.solid,
                          decorationThickness: 2),
                    ),
                    SvgPicture.asset(
                      'assets/icons/filter.svg',
                      height: 30,
                    )
                  ],
                ),
              ),
              const TaskContainer(),
              const TaskContainer(),
              const TaskContainer(),
              const TaskContainer(),
              const TaskContainer(),
              const SizedBox(height: 5,),
            ]))
      ]),
    );
  }
}