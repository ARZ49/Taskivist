import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:taskivist/controller/database.dart';
import 'package:taskivist/custom_app_bar.dart';
import 'package:taskivist/task_container.dart';
import 'package:taskivist/utilities/app_colors.dart';

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
  bool isLastest = false;
  bool isOldest = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
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
                    PopupMenuButton(
                        icon: SvgPicture.asset(
                          'assets/icons/filter.svg',
                          height: 30,
                        ),
                        onSelected: (value) async {
                          if (value == 'Sort by Recent') {
                            isLoading = true;
                            final recent =
                                await DataBaseHelper().sortByLastest();
                            setState(() {
                              recentTask = recent;
                              isLastest = true;
                              isOldest = false;
                            });
                            print(recent);
                          } else {
                            final oldest =
                                await DataBaseHelper().sortByOldest();
                            setState(() {
                              oldestTask = oldest;
                              isOldest = true;
                              isLastest = false;
                            });
                            print(oldest);
                          }

                          await Future.delayed(Duration(seconds: 2));
                          setState(() {
                            isLoading = false;
                          });
                        },
                        itemBuilder: (context) => items.map((e) {
                              return PopupMenuItem(
                                child: Text(e),
                                value: e,
                              );
                            }).toList()),
                  ],
                ),
              ),
              StreamBuilder(
                  stream: searchController.text.isNotEmpty
                      ? filter(searchController.text).asStream()
                      : isLastest
                          ? DataBaseHelper().sortByLastest().asStream()
                          : isOldest
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
                    return isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
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
