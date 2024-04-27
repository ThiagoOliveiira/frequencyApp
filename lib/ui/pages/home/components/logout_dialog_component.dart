import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/theme.dart';

class LogoutDialogComponent {
  static void dialog() {
    Get.defaultDialog(
      backgroundColor: Colors.white,
      title: '',
      radius: 15,
      barrierDismissible: false,
      content: const Column(
        children: [
          SizedBox(height: 30, width: 30, child: CircularProgressIndicator(strokeWidth: 2, color: AppColor.bluegreen600)),
          SizedBox(height: 20),
          Text('Saindo...', style: TextStyle(fontWeight: FontWeight.w600, color: AppColor.bluegreen600))
        ],
      ),
    );
  }
}
