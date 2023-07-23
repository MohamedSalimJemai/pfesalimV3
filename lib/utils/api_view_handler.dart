import 'package:flutter/cupertino.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../api/response/api_response.dart';
import '../api/response/status.dart';
import 'alert_utils.dart';
import 'language/localization.dart';

class ApiViewHandler {
  static Future<void> handleApiCallWithAlert({
    required BuildContext context,
    bool showIndicator = true,
    required Future<ApiResponse> Function() apiCall,
    required Function successFunction,
    Function? failureFunction,
  }) async {
    if (showIndicator) context.loaderOverlay.show();
    await apiCall().then((apiResponse) {
      if (apiResponse.status == Status.completed) {
        successFunction();
      } else {
        if (failureFunction != null) {
          failureFunction();
        } else {
          AlertMaker.showSimpleAlertDialog(
            context: context,
            title: intl.error,
            content: apiResponse.message,
            isDanger: true,
          );
        }
      }
    }).whenComplete(() {
      if (showIndicator) context.loaderOverlay.hide();
    });
  }
}
