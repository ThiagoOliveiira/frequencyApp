import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/theme.dart';

class SnackbarError {
  static bool preventMultipleSnacks = false;

  static void snackbarError({required String? title, required String? message}) {
    if (preventMultipleSnacks == false) {
      preventMultipleSnacks = true;
      if (!Get.isSnackbarOpen)
        Get.rawSnackbar(
            backgroundColor: AppColor.coral, title: title, message: message, padding: const EdgeInsets.all(10), margin: const EdgeInsets.all(10), borderRadius: 20, icon: const Icon(Icons.error));
      preventMultipleSnacks = false;
    }
  }
}
