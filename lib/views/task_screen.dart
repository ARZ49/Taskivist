import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskivist/custom_app_bar.dart';
import 'package:taskivist/task_container.dart';
import 'package:taskivist/utilities/app_colors.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: AppColors.accentColor,
          child: const Icon(
            Icons.add,
            color: AppColors.secondaryColor,
            size: 30,
          ),
        ),
        body: CustomScrollView(
          slivers: [
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
                      'Task List',
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
              const TaskContainer(isCompleted: true,),
              const TaskContainer(),
              const TaskContainer(isCompleted: true,),
              const TaskContainer(),
              const SizedBox(height: 5,),
            ]))
          ],
        ));
  }
}
