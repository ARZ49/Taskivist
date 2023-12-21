import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:taskivist/controller/controller.dart';
// ignore: must_be_immutable
class TaskHeader extends StatefulWidget {
  final List items;
  const TaskHeader({
    super.key,
    required this.items,
   
  });

  @override
  State<TaskHeader> createState() => _TaskHeaderState();
}

class _TaskHeaderState extends State<TaskHeader> {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<Controller>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Task List',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.solid,
                decorationThickness: 2),
          ),
        ),
       
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: PopupMenuButton(
              icon: SvgPicture.asset(
                'assets/icons/filter.svg',
                height: 30,
              ),
              onSelected: (value){
                
                controller.sortBy(value);
                
              },
              itemBuilder: (context) => widget.items.map((e) {
                    return PopupMenuItem(
                      value: e,
                      child: Text(e),
                    );
                  }).toList()),
        ),
      ],
    );
  }
}
