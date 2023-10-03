import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../ui/ui.dart';
import '../page.dart';

Widget makeSplashPage() {
  final presenter = Get.put<SplashPresenter>(makeSplashPresenter());
  return SplashPage(presenter: presenter);
}
