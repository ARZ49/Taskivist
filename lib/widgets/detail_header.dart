import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskivist/widgets/update_dialog.dart';
import 'package:taskivist/utilities/app_colors.dart';

class DetailHeader extends StatelessWidget {
  const DetailHeader({super.key, required this.editingController, this.snapshot, required this.onPressed, required this.header, required this.hintText, required this.title});
  final TextEditingController editingController;
  final dynamic snapshot;
  final VoidCallback onPressed;
  final String header;
  final String hintText,title;
  @override
  Widget build(BuildContext context) {
    return   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          header,
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
                                      editingController: editingController,
                                      hintText: hintText,
                                      title: title,
                                      onPressed: onPressed);
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
                  );
  }
}