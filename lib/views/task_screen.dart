import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:taskivist/controller/controller.dart';
import 'package:taskivist/controller/database.dart';
import 'package:taskivist/widgets/custom_app_bar.dart';
import 'package:taskivist/widgets/task_container.dart';
import 'package:taskivist/utilities/app_colors.dart';

import '../widgets/task_header.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List items = [
    'Sort by Recent',
    'Sort by Oldest',
  ];
  List oldestTask = [];
  List recentTask = [];
  Future<List> filter(String title) async {
    final db = await DataBaseHelper().getAllTasks();
    final filteredList = db
        .where((element) => element['title'].toString().contains(title))
        .toList();
    return filteredList;
  }

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<Controller>(context);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.go('/add-task-screen'),
          backgroundColor: AppColors.accentColor,
          child: const Icon(
            Icons.add,
            color: AppColors.secondaryColor,
            size: 30,
          ),
        ),
        body: CustomScrollView(
          slivers: [
            CustomAppBar(
              searchController: searchController,
              onSubmitted: (value) {
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
              TaskHeader(
                items: items,
              ),
              StreamBuilder(
                  stream: searchController.text.isNotEmpty
                      ? filter(searchController.text).asStream()
                      : controller.sorted == SortBy.recent
                          ? DataBaseHelper().sortByLastest().asStream()
                          : controller.sorted == SortBy.oldest
                              ? DataBaseHelper().sortByOldest().asStream()
                              : DataBaseHelper().getAllTasks().asStream(),
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
                    return controller.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            children:
                                List.generate(snapshot.data!.length, (index) {
                            return Dismissible(
                              key: Key('key'),
                             direction: DismissDirection.endToStart,
                              background: Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Icon(Icons.delete,color: AppColors.primaryColor,size: 30,),
                                )),
                              confirmDismiss: (direction) {
                              return    showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        backgroundColor: AppColors.primaryColor,
                                        content: Text(
                                            'Are you sure you want to delete this?',style: TextStyle(color: AppColors.secondaryColor,fontSize: 18),),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                   GoRouter.of(context).pop();
                                              },
                                              child: Text("Close")),
                                          TextButton(
                                              onPressed: () {
                                                DataBaseHelper().deleteUser(
                                                    snapshot.data![index]
                                                        ['id']);
                                                setState(() {});
                                                GoRouter.of(context).pop();
                                              },
                                              child: Text('Delete'))
                                        ],
                                      );
                                    });
                              },
                              // onDismissed: (direction) {
                              //   showDialog(
                              //       context: context,
                              //       builder: (context) {
                              //         return AlertDialog(
                              //           content: Text(
                              //               'Are you sure you want to delete this?'),
                              //           actions: [
                              //             TextButton(
                              //                 onPressed: () {
                              //                      GoRouter.of(context).pop();
                              //                 },
                              //                 child: Text("Close")),
                              //             TextButton(
                              //                 onPressed: () {
                              //                   DataBaseHelper().deleteUser(
                              //                       snapshot.data![index]
                              //                           ['id']);
                              //                   setState(() {});
                              //                   GoRouter.of(context).pop();
                              //                 },
                              //                 child: Text('Delete'))
                              //           ],
                              //         );

                              //       });
                              // },
                              child: TaskContainer(
                                onLongPress: () {
                                  DataBaseHelper()
                                      .deleteUser(snapshot.data![index]['id']);
                                  setState(() {});
                                  GoRouter.of(context).pop();
                                },
                                title: snapshot.data![index]['title'],
                                description: snapshot.data![index]
                                    ['description'],
                                date: snapshot.data![index]['date'],
                                onTap: () => context.go(
                                  '/task-detail-screen',
                                  extra: snapshot.data![index],
                                ),
                              ),
                            );
                          }).reversed.toList());
                  }),
              const SizedBox(
                height: 5,
              ),
            ]))
          ],
        ));
  }
}
