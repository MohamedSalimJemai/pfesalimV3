import 'package:flutter/material.dart';

import '../../utils/dimensions.dart';
import '../../utils/language/localization.dart';
import '../../utils/theme/theme_styles.dart';

class CustomDialogBox extends StatelessWidget {
  final VoidCallback? positiveAction;
  final VoidCallback? negativeAction;
  final bool isMultipleActions;
  final String? positiveActionTitle;
  final String? negativeActionTitle;
  final String title;
  final String description;
  final bool isSuccess;
  final bool isDanger;
  final bool isWarning;
  final bool isNotice;
  final Widget? widget;

  const CustomDialogBox({
    Key? key,
    this.positiveAction,
    this.negativeAction,
    this.isMultipleActions = false,
    this.positiveActionTitle,
    this.negativeActionTitle,
    this.title = "",
    this.description = "",
    this.isSuccess = false,
    this.isDanger = false,
    this.isWarning = false,
    this.isNotice = false,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late IconData icon;
    late Color mainColor;

    if (isDanger) {
      mainColor = dangerColor;
      icon = Icons.error;
    } else if (isWarning) {
      mainColor = warningColor;
      icon = Icons.warning;
    } else if (isSuccess) {
      mainColor = successColor;
      icon = Icons.check_circle;
    } else if (isNotice) {
      mainColor = noticeColor;
      icon = Icons.info;
    } else {
      mainColor = Colors.grey.shade500;
      icon = Icons.question_mark;
    }

    final screenHeight = MediaQuery.of(context).size.height;

    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: Dimensions.roundedBorderBig,
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 500,
          maxHeight: screenHeight - 200,
        ),
        padding: Dimensions.bigPadding,
        decoration: BoxDecoration(
          color: Styles.primaryBackgroundColor.withOpacity(0.95),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget != null
                ? widget!
                : Column(
                    children: [
                      Icon(icon, size: 75, color: mainColor),
                      const SizedBox(height: 20),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: mainColor,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(description),
                      const SizedBox(height: 20),
                    ],
                  ),
            Row(
              children: [
                if (positiveAction == null)
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(mainColor),
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            side: BorderSide(
                              color: mainColor,
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: Dimensions.roundedBorderMedium,
                          ),
                        ),
                      ),
                      child: Text(intl.ok),
                    ),
                  ),
                if (positiveAction != null)
                  isMultipleActions
                      ? Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    if (negativeAction != null) {
                                      negativeAction!();
                                    }
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                      Styles.backgroundColor,
                                    ),
                                  ),
                                  child: Text(
                                    negativeActionTitle ?? intl.no,
                                    style: TextStyle(color: Styles.textColor),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    if (positiveAction != null) {
                                      positiveAction!();
                                    }
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(mainColor),
                                  ),
                                  child: Text(
                                    positiveActionTitle ?? intl.yes,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Expanded(
                          child: TextButton(
                            onPressed: positiveAction,
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(mainColor),
                            ),
                            child: Text(intl.proceed),
                          ),
                        )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
