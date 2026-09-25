import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'viewmodel/report_block_menu_viewmodel.dart';

class ReportBlockMenu extends StatefulWidget {
  final String userId;
  final String? feedId;
  final VoidCallback? onBlocked;
  final Color? iconColor;

  const ReportBlockMenu({
    super.key,
    required this.userId,
    this.feedId,
    this.onBlocked,
    this.iconColor,
  });

  @override
  State<ReportBlockMenu> createState() => _ReportBlockMenuState();
}

class _ReportBlockMenuState extends ReportBlockMenuViewmodel {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert,
          color: widget.iconColor ?? Theme.of(context).colorScheme.surface),
      onSelected: (value) {
        if (value == 'report') {
          showDialog(
              context: context, builder: (context) => reportDialog(context));
        } else if (value == 'block') {
          showDialog(
              context: context,
              builder: (context) => blockConfirmDialog(context));
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(value: 'report', child: Text('report'.tr)),
        PopupMenuItem(value: 'block', child: Text('block'.tr)),
      ],
    );
  }
}
