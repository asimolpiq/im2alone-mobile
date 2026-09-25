import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/colors/app_colors.dart';

import '../../../../core/helpers/request_helper.dart';
import '../../../../service/user/user_service.dart';
import '../../snackbar/custom_snacbars.dart';
import '../report_block_menu.dart';

abstract class ReportBlockMenuViewmodel extends State<ReportBlockMenu> {
  late UserService userService;
  String? selectedReason;
  final TextEditingController descriptionController = TextEditingController();

  final Map<String, String> reportReasons = {
    'nudity': 'report_reason_nudity',
    'harassment': 'report_reason_harassment',
    'spam': 'report_reason_spam',
    'violence': 'report_reason_violence',
    'hate_speech': 'report_reason_hate_speech',
    'other': 'report_reason_other',
  };

  @override
  void initState() {
    super.initState();
    userService = UserService(RequestHelper().dio);
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  blockUser() async {
    final response = await userService.blockUser(widget.userId);
    if (response) {
      Get.showSnackbar(
          CustomSnackbars.successSnack(message: 'user_blocked'.tr));
      widget.onBlocked?.call();
    } else {
      Get.showSnackbar(
          CustomSnackbars.errorSnack(error: 'user_block_failed'.tr));
    }
  }

  reportContent() async {
    if (selectedReason == null) {
      Get.showSnackbar(
          CustomSnackbars.errorSnack(error: 'report_reason_error'.tr));
      return;
    }
    final response = await userService.reportContent(
      reportedUserID: widget.userId,
      feedID: widget.feedId,
      reason: selectedReason!,
      description: descriptionController.text,
    );
    if (response) {
      Get.showSnackbar(CustomSnackbars.successSnack(message: 'report_sent'.tr));
    } else {
      Get.showSnackbar(
          CustomSnackbars.errorSnack(error: 'report_send_failed'.tr));
    }
  }

  AlertDialog blockConfirmDialog(BuildContext context) {
    return AlertDialog(
      title: Text('block_user_confirm_title'.tr),
      content: Text('block_user_confirm_body'.tr),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text('cancel'.tr),
        ),
        TextButton(
          onPressed: () {
            Get.back();
            blockUser();
          },
          child: Text('block'.tr,
              style: TextStyle(color: Theme.of(context).colorScheme.error)),
        ),
      ],
    );
  }

  AlertDialog reportDialog(BuildContext context) {
    selectedReason = null;
    descriptionController.clear();
    final theme = Theme.of(context);
    return AlertDialog(
      title: Text('report_user'.tr),
      contentPadding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
      content: StatefulBuilder(
        builder: (context, setDialogState) => SizedBox(
          // Dialog'un tam genisligini kullan, dar ekranda metin kirilmasin.
          width: double.maxFinite,
          child: ConstrainedBox(
            // Kucuk ekranlarda tasmak yerine icerik kaysin.
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.5,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'report_reason'.tr,
                    style: theme.dialogTheme.contentTextStyle
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  ...reportReasons.entries.map(
                    (entry) => RadioListTile<String>(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      visualDensity: VisualDensity.compact,
                      activeColor: theme.colorScheme.primary,
                      title: Text(
                        entry.value.tr,
                        style: theme.dialogTheme.contentTextStyle,
                      ),
                      value: entry.key,
                      groupValue: selectedReason,
                      onChanged: (value) =>
                          setDialogState(() => selectedReason = value),
                    ),
                  ),
                  TextField(
                    controller: descriptionController,
                    maxLines: 3,
                    style: theme.dialogTheme.contentTextStyle,
                    cursorColor: theme.colorScheme.primary,
                    decoration: InputDecoration(
                      hintText: 'report_description_hint'.tr,
                      hintStyle: theme.dialogTheme.contentTextStyle
                          ?.copyWith(color: AppColors.white.withValues(alpha: 0.5)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.white.withValues(alpha: 0.3)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: theme.colorScheme.primary),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text('cancel'.tr),
        ),
        TextButton(
          onPressed: () {
            Get.back();
            reportContent();
          },
          child: Text('submit_report'.tr),
        ),
      ],
    );
  }
}
