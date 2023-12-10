// ignore_for_file: must_be_immutable

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:taskivist/utilities/app_colors.dart';

class CustomCalender extends StatelessWidget {
 const  CustomCalender({super.key, required this.onValueChanged, required this.value});
   final Function(List<DateTime?> value ) onValueChanged;
   final List<DateTime?> value;
  @override
  Widget build(BuildContext context) {
    return   Positioned(
                    top: 100,
                    right: -2,
                    left: -2,
                    child: Container(
                      height: 300,
                      decoration: const BoxDecoration(
                          color: AppColors.secondaryColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15))),
                      width: double.infinity,
                      child: CalendarDatePicker2(
                        config: CalendarDatePicker2Config(
                          calendarType: CalendarDatePicker2Type.single,
                          controlsTextStyle:
                              Theme.of(context).textTheme.bodyMedium,
                          customModePickerIcon: const SizedBox(),
                          dayTextStyle: Theme.of(context).textTheme.bodyMedium,
                          nextMonthIcon: const Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: AppColors.accentColor,
                          ),
                          selectedDayHighlightColor: AppColors.primaryColor,
                          weekdayLabelTextStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: AppColors.accentColor.withOpacity(0.8)),
                          selectedDayTextStyle:
                              Theme.of(context).textTheme.bodyMedium,
                          lastMonthIcon: const Icon(
                            Icons.arrow_back_ios_sharp,
                            color: AppColors.accentColor,
                          ),
                        ),
                        value: value,
                        onValueChanged: onValueChanged,
                      ),
                    ));
  }
}