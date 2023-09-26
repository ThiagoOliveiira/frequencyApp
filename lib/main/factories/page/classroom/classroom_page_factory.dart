import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../ui/ui.dart';
import '../../factories.dart';

Widget makeClassroomPage() {
  final presenter = Get.put<ClassroomPresenter>(makeGetxClassroomPresenter());
  return ClassroomPage(presenter: presenter);
}
