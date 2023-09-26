import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../ui/ui.dart';
import '../page.dart';

Widget makeHomePage() {
  final presenter = Get.put<HomePresenter>(makeGetxHomePresenter());
  return HomePage(presenter: presenter);
}
