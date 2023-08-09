import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:taskivist/custom_app_bar.dart';
import 'package:taskivist/utilities/app_colors.dart';

import '../controller/database.dart';
import '../task_container.dart';

class PendingTaskScreen extends StatefulWidget {
  const PendingTaskScreen({super.key});

  @override
  State<PendingTaskScreen> createState() => _PendingTaskScreenState();
}

class _PendingTaskScreenState extends State<PendingTaskScreen> {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: CustomScrollView(slivers: [
        CustomAppBar(searchController: searchController,onSubmitted: (value){
           setState(() {
              searchController.text = value;
            });
        },),
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
                  StreamBuilder(
                  stream:  DataBaseHelper().getAllTasks().asStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Container(
                          margin: const EdgeInsets.only(top: 35),
                          child: Column(
                            children: [
                              Center(
                                  child: Image.asset(
                                'assets/images/empty_task.png',
                              )),
                              Text(
                                'There are no task yet',
                                style: Theme.of(context).textTheme.bodyLarge,
                              )
                            ],
                          ));
                    }
                    return  Column(
                            children:
                                List.generate(snapshot.data!.length, (index) {
                            return TaskContainer(
                              onLongPress: () {
                                DataBaseHelper()
                                    .deleteUser(snapshot.data![index]['id']);
                                setState(() {});
                                GoRouter.of(context).pop();
                              },
                              title: snapshot.data![index]['title'],
                              description: snapshot.data![index]['description'],
                              date: snapshot.data![index]['date'],
                              onTap: () => context.go(
                                '/task-detail-screen',
                                extra: snapshot.data![index],
                              ),
                            );
                          }));
                  }),
              const SizedBox(height: 5,),
            ]))
      ]),
    );
  }
}