import 'package:flutter/widgets.dart';
import 'package:frequency_app/main/factories/page/login/login_presenter_factory.dart';
import 'package:get/get.dart';

import '../../../../ui/ui.dart';

Widget makeLoginPage() {
  final presenter = Get.put<LoginPresenter>(makeGetxLoginPresenter());
  return LoginPage(presenter: presenter);
}
