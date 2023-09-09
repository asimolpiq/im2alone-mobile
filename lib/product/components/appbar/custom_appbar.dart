import 'package:flutter/material.dart';
import 'package:im2alone/product/consts/radius/project_radius.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key, required this.title, this.leading, this.actions, this.bgColor});
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const ProjectRadius.appbarRadius(),
      child: AppBar(
        actions: actions,
        leading: leading,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.surface),
        title: Text(
          title,
          overflow: TextOverflow.fade,
          style: TextStyle(color: Theme.of(context).colorScheme.surface, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
