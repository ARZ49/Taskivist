import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sqflite/sqflite.dart';
import 'package:taskivist/widgets/custom_app_bar.dart';

import '../controller/database.dart';
import '../widgets/task_container.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  final TextEditingController searchController = TextEditingController();
  Future completedTask()async{
   final task = await DataBaseHelper().getAllTasks();
 final completedTask =  task.where((element) => element['isCompleted'] == 'True').toList();
   return completedTask;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        CustomAppBar(
          searchController: searchController,
          onSubmitted: (value){
             setState(() {
              searchController.text = value;
            });
          },
        ),
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
                   StreamBuilder(
                  stream: completedTask().asStream(),
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
                    return Column(
                            children:
                                List.generate(snapshot.data!.length, (index) {
                            return TaskContainer(
                              isCompleted: snapshot.data![index]['isCompleted'],
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