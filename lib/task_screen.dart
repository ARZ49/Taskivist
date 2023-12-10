// import 'package:flutter/material.dart';
// import 'package:taskivist/models/task.dart';

// class TaskScreen extends StatefulWidget {
//   const TaskScreen({super.key});

//   @override
//   State<TaskScreen> createState() => _TaskScreenState();
// }

// class _TaskScreenState extends State<TaskScreen> {
//   List<Task> tasks = [];

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text("Todo App")),
//         body: Column(children: [
//           Expanded(
//               child: ListView.builder(
//                   itemCount: tasks.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text(tasks[index].title),
//                       leading: Checkbox(
//                         value: tasks[index].isCompleted,
//                         onChanged: (value) {
//                           setState(() {
//                             tasks[index].isCompleted = value!;
//                           });
//                         },
//                       ),
//                     );
//                   })),
//           ElevatedButton(
//             child: const Text("Add Task"),
//             onPressed: () {
//               setState(() {
//                 tasks.add(
//                   Task(
//                       title: "New Task",
//                       description: 'kdsfksmkfsmkvs',
//                       date: DateTime.now().toString(),
//                       isCompleted: false.toString()),
//                 );
//               });
//             },
//           )
//         ]),
//       ),
//     );
//   }
// }
