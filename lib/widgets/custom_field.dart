import 'package:flutter/material.dart';

import '../utilities/app_colors.dart';

class CustomField extends StatelessWidget{
  final TextEditingController controller;
  final String hintText;
  final int maxLines;

  CustomField({required this.controller,required this.hintText,this.maxLines = 1});
  @override
  Widget build(BuildContext context){
    return    Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLines: maxLines,
                style: Theme.of(context).textTheme.bodySmall,
                controller: controller,
                decoration: InputDecoration(
              
                    hintText: hintText,
                    hintStyle: Theme.of(context).textTheme.bodyMedium,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none),
                    fillColor: AppColors.secondaryColor,
                    filled: true),
              ),
            );
  }
}