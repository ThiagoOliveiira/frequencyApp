import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../theme/theme.dart';

class ConfirmPresenceDialogComponent {
  static void dialog({required bool isPresent}) {
    Get.dialog(AlertDialog(
      title: SvgPicture.asset('assets/icons/check-square.svg', color: isPresent ? Colors.green : Colors.red, height: 50),
      backgroundColor: AppColor.bluegreen.withOpacity(0.8),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Text(isPresent ? 'Presença confirmada' : 'Sua informações não estão dentro do perímetro da aula', textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 15)),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () => Get.back(),
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(AppColor.grey100),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),
              overlayColor: MaterialStatePropertyAll(AppColor.grey500),
              padding: MaterialStatePropertyAll((EdgeInsets.symmetric(vertical: 15, horizontal: 10))),
            ),
            child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Fechar', style: TextStyle(color: AppColor.bluegreen600, fontSize: 18))]),
          )
        ],
      ),
    ));
  }
}
