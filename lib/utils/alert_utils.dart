import 'package:flutter/material.dart';

import '../view/widgets/custom_dialog_box.dart';

class AlertMaker {
  static void showSimpleAlertDialog({
    required BuildContext context,
    required String title,
    required String content,
    bool isSuccess = false,
    bool isDanger = false,
    bool isWarning = false,
    bool isNotice = false,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CustomDialogBox(
          title: title,
          description: content,
          isSuccess: isSuccess,
          isDanger: isDanger,
          isWarning: isWarning,
          isNotice: isNotice,
        );
      },
    );
  }

  static void showSingleActionAlertDialog({
    required BuildContext context,
    required String title,
    required String content,
    required VoidCallback? action,
    bool isSuccess = false,
    bool isDanger = false,
    bool isWarning = false,
    bool isNotice = false,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CustomDialogBox(
          title: title,
          description: content,
          positiveAction: action,
          isSuccess: isSuccess,
          isDanger: isDanger,
          isWarning: isWarning,
          isNotice: isNotice,
        );
      },
    );
  }

  static Future<void> showActionAlertDialog({
    required BuildContext context,
    required String title,
    required String content,
    required VoidCallback? positiveAction,
    required VoidCallback? negativeAction,
    required String positiveActionTitle,
    required String negativeActionTitle,
    bool isSuccess = false,
    bool isDanger = false,
    bool isWarning = false,
    bool isNotice = false,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CustomDialogBox(
          title: title,
          description: content,
          positiveAction: positiveAction,
          negativeAction: negativeAction,
          isMultipleActions: true,
          positiveActionTitle: positiveActionTitle,
          negativeActionTitle: negativeActionTitle,
          isSuccess: isSuccess,
          isDanger: isDanger,
          isWarning: isWarning,
          isNotice: isNotice,
        );
      },
    );
  }

  static Future<void> showWidgetAlertDialog({
    required BuildContext context,
    required Widget widget,
    bool isSuccess = false,
    bool isDanger = false,
    bool isWarning = false,
    bool isNotice = false,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CustomDialogBox(
          isSuccess: isSuccess,
          isDanger: isDanger,
          isWarning: isWarning,
          isNotice: isNotice,
          widget: widget,
        );
      },
    );
  }
}
