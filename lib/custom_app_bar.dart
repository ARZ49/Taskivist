import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskivist/utilities/app_colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return   SliverAppBar(
              pinned: true,
              backgroundColor: AppColors.primaryColor,
              centerTitle: true,
              expandedHeight: 70,
              collapsedHeight: 60,
              flexibleSpace: Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 45),
                  width: 300,
                  height: 35,
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        focusColor: Colors.transparent,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        contentPadding: const EdgeInsets.all(3),
                        hintText: 'Search by title',
                        hintStyle: Theme.of(context).textTheme.bodySmall,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: SvgPicture.asset(
                            'assets/icons/search.svg',
                          ),
                        ),
                        fillColor: AppColors.secondaryColor,
                        filled: true),
                    cursorColor: AppColors.accentColor,
                  ),
                ),
              ),
            );
  }
}