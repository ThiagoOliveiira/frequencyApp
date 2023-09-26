import 'package:get/get.dart';

import '../theme/theme.dart';

class SnackbarError {
  static bool preventMultipleSnacks = false;

  static void snackbarError({required String? title, required String? message}) {
    if (preventMultipleSnacks == false) {
      preventMultipleSnacks = true;
      if (!Get.isSnackbarOpen) Get.rawSnackbar(backgroundColor: AppColor.coral, title: title, message: message);
      preventMultipleSnacks = false;
    }
  }
}
