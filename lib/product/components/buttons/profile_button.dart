import 'package:flutter/material.dart';

import '../../consts/paddings/project_paddings.dart';
import '../../consts/radius/project_radius.dart';
import '../../theme/colors/app_colors.dart';

class ProfileButtton extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final Icon icon;
  final Color textColor;
  const ProfileButtton(
      {super.key, required this.onPressed, required this.text, required this.icon, this.textColor = AppColors.white});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.secondary,
      child: Padding(
        padding: const ProjectPaddings.all8(),
        child: InkWell(
          onTap: onPressed,
          borderRadius: ProjectRadius.circular30(),
          enableFeedback: true,
          highlightColor: AppColors.transparent,
          child: ListTile(
            leading: icon,
            title: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
