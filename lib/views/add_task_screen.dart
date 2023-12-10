import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:taskivist/controller/database.dart';
import 'package:taskivist/widgets/custom_button.dart';
import 'package:taskivist/widgets/custom_calender.dart';
import 'package:taskivist/models/Task.dart';
import 'package:taskivist/utilities/app_colors.dart';

import '../widgets/custom_field.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController titleEditingController = TextEditingController();
  final TextEditingController descriptionEditingController =
      TextEditingController();
  List<DateTime?> dates = [];
 @override
  void dispose() {
   titleEditingController.dispose();
    descriptionEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 400,
              child: Stack(children: [
                Positioned(
                  child: Container(
                    width: double.infinity,
                    decoration:
                        const BoxDecoration(color: AppColors.primaryColor),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Add Task',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontSize: 28),
                              ),
                              IconButton(
                                  onPressed: () => context.go('/main-page'),
                                  icon: const Icon(Icons.close,
                                      size: 30, color: AppColors.accentColor))
                            ],
                          ),
                          Text(
                            "Lets's be productive!",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 28),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                CustomCalender(
                  value: dates,
                  onValueChanged: (date) {
                    dates = date;
                  },
                )
              ]),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomField(
              controller: titleEditingController,
              hintText: 'Enter title',
            ),
           CustomField(
            controller: descriptionEditingController,
            hintText: 'Enter description',
            maxLines: 4,
           ),
           
            CustomButton(
              onPressed: () {
        DataBaseHelper().saveTask(Task(
                    title: titleEditingController.text,
                    description: descriptionEditingController.text,
                    date: DateFormat.yMMMd().format(dates.first!)));
                context.go('/main-page');
                 
              },
            )
          ]),
        ),
      ),
    );
  }
}
