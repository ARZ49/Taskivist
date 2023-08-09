import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:taskivist/controller/database.dart';
import 'package:taskivist/detail_container.dart';
import 'package:taskivist/models/Task.dart';
import 'package:taskivist/update_dialog.dart';
import 'package:taskivist/utilities/app_colors.dart';

class TaskDetailScreen extends StatefulWidget {
  TaskDetailScreen({super.key, required this.snapshot});
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
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 30,
                      color: AppColors.secondaryColor,
                    ),
                    onPressed: () {
                      context.go('/main-page');
                    },
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Title',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: AppColors.secondaryColor,
                                  fontSize: 24),
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return UpdateDialog(
                                      editingController: titleEditingController,
                                      hintText: 'Update title',
                                      title: 'Edit Title',
                                      onPressed: () {
                                        DataBaseHelper().updateTask(
                                            widget.snapshot['id'],
                                            Task(
                                                title:
                                                    titleEditingController.text,
                                                description: widget
                                                    .snapshot['description'],
                                                date: widget.snapshot['date']));
                                        setState(() {});
                                        titleEditingController.dispose();
                                        descriptionEditingController.dispose();
                                        GoRouter.of(context).pop();
                                      });
                                });
                          },
                          child: SvgPicture.asset(
                            'assets/icons/edit.svg',
                            height: 35,
                            width: 35,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(snapshot.data!.title,
                        style: Theme.of(context).textTheme.bodyMedium),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Description',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: AppColors.secondaryColor,
                                  fontSize: 24),
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return UpdateDialog(
                                      editingController:
                                          descriptionEditingController,
                                      hintText: 'Update Description',
                                      title: 'Edit Description',
                                      onPressed: () {
                                        DataBaseHelper().updateTask(
                                            widget.snapshot['id'],
                                            Task(
                                                title: widget.snapshot['title'],
                                                description:
                                                    descriptionEditingController
                                                        .text,
                                                date: widget.snapshot['date']));
                                        setState(() {});
                                        titleEditingController.dispose();
                                        descriptionEditingController.dispose();
                                        GoRouter.of(context).pop();
                                      });
                                });
                          },
                          child: SvgPicture.asset(
                            'assets/icons/edit.svg',
                            height: 35,
                            width: 35,
                          ),
                        )
                      ],
                    ),
                  ),
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
