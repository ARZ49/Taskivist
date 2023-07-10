import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskivist/custom_app_bar.dart';

import '../task_container.dart';

class CompletedTaskScreen extends StatelessWidget {
  const CompletedTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      'Completed',
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
              const TaskContainer(isCompleted: true,),
              const TaskContainer(isCompleted: true,),
              const TaskContainer(isCompleted: true,),
              const TaskContainer(isCompleted: true,),
              const TaskContainer(isCompleted: true,),
              const SizedBox(height: 5,),
            ]))
      ]),
    );
  }
}