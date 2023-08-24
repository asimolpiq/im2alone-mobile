import 'package:flutter/material.dart';

import '../../consts/colors/project_colors.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key, required this.title, this.leading, this.actions, this.bgColor});
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(15),
        bottomRight: Radius.circular(15),
      ),
      child: AppBar(
        actions: actions,
        leading: leading,
        iconTheme: const IconThemeData(color: ProjectColors.white),
        backgroundColor: bgColor ?? ProjectColors.primaryColor,
        title: Text(
          title,
          style: const TextStyle(color: ProjectColors.black),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
