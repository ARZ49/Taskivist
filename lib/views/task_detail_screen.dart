import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskivist/controller/database.dart';
import 'package:taskivist/widgets/detail_container.dart';
import 'package:taskivist/widgets/detail_header.dart';
import 'package:taskivist/models/Task.dart';
import 'package:taskivist/utilities/app_colors.dart';

class TaskDetailScreen extends StatefulWidget {
  const TaskDetailScreen({super.key, required this.snapshot});
  final dynamic snapshot;

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  final TextEditingController titleEditingController = TextEditingController();
  final TextEditingController descriptionEditingController =
      TextEditingController();

  @override
  void dispose() {
    titleEditingController.dispose();
    descriptionEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
          child: SingleChildScrollView(
        child: StreamBuilder(
            stream: DataBaseHelper().getTask(widget.snapshot['id']).asStream(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 28,
                          color: AppColors.secondaryColor,
                        ),
                        onPressed: () {
                          context.go('/main-page');
                        },
                      ),
                      // widget.snapshot['isCompleted'] == 'True'?Container() :
                      PopupMenuButton(
                        iconSize: 30,
                        color: AppColors.secondaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                                value: 0,
                                onTap: () {
                                  DataBaseHelper().updateTask(
                                      widget.snapshot['id'],
                                      Task(
                                          isCompleted:
                                              widget.snapshot['isCompleted'] ==
                                                      'True'
                                                  ? 'False'
                                                  : 'True',
                                          title: widget.snapshot['title'],
                                          description:
                                              widget.snapshot['description'],
                                          date: widget.snapshot['date']));
                                  titleEditingController.clear();
                                  descriptionEditingController.clear();
                              
                                     setState(() {});
                                     context.replace(
                                      '/main-page',
                                     );
                                      
                                },
                                child: Text(
                                  widget.snapshot['isCompleted'] == 'True'
                                      ? 'Unmark as Completed'
                                      : 'Mark as Complete',
                                  style: const TextStyle(
                                      color: AppColors.accentColor,
                                      fontSize: 18),
                                )),
                            PopupMenuItem(
                                value: 1,
                                onTap: () {
                                  Future.delayed(Duration.zero).then((value) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            backgroundColor:
                                                AppColors.secondaryColor,
                                            content: const Text(
                                              'Are you sure you want to delete this?',
                                              style: TextStyle(
                                                  color: AppColors.accentColor,
                                                  fontSize: 20),
                                            ),
                                            actions: [
                                              TextButton(
                                                  style: TextButton.styleFrom(
                                                      foregroundColor: AppColors
                                                          .accentColor),
                                                  onPressed: () {
                                                    GoRouter.of(context).pop();
                                                  },
                                                  child: const Text(
                                                    "Close",
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  )),
                                              TextButton(
                                                  style: TextButton.styleFrom(
                                                      foregroundColor: AppColors
                                                          .accentColor),
                                                  onPressed: () {
                                                    DataBaseHelper().deleteUser(
                                                        widget.snapshot['id']);
                                                    setState(() {});
                                                    GoRouter.of(context).pop();
                                                  },
                                                  child: const Text(
                                                    'Delete',
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ))
                                            ],
                                          );
                                        });
                                  });
                                },
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(
                                      color: AppColors.accentColor,
                                      fontSize: 18),
                                )),
                          ];
                        },
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          snapshot.data!.date,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  DetailHeader(
                      header: 'Title',
                      hintText: 'Update Title',
                      title: 'Edit Title',
                      editingController: titleEditingController,
                      onPressed: () {
                        DataBaseHelper().updateTask(
                            widget.snapshot['id'],
                            Task(
                                isCompleted: widget.snapshot['isCompleted'],
                                title: titleEditingController.text,
                                description: widget.snapshot['description'],
                                date: widget.snapshot['date']));
                        titleEditingController.clear();
                        descriptionEditingController.clear();
                        GoRouter.of(context).pop();
                        setState(() {});
                      }),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(snapshot.data!.title,
                        style: Theme.of(context).textTheme.bodyMedium),
                  ),
                  DetailHeader(
                      editingController: descriptionEditingController,
                      onPressed: () {
                        DataBaseHelper().updateTask(
                            widget.snapshot['id'],
                            Task(
                                isCompleted: widget.snapshot['isCompleted'],
                                title: widget.snapshot['title'],
                                description: descriptionEditingController.text,
                                date: widget.snapshot['date']));
                        GoRouter.of(context).pop();
                        titleEditingController.clear();
                        descriptionEditingController.clear();
                        setState(() {});
                      },
                      header: 'Description',
                      hintText: 'Update Description',
                      title: 'Edit Description'),
                  const SizedBox(
                    height: 5,
                  ),
                  DetailContainer(description: snapshot.data!.description),
                ],
              );
            }),
      )),
    );
  }
}
