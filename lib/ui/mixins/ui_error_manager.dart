import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ui.dart';

mixin UIErrorManager {
  void handleMainError(BuildContext context, Rxn<UIError?> stream, String title) {
    stream.listen((error) {
      if (error != null) SnackbarError.snackbarError(title: title, message: error.description);
    });
    stream.value = null;
  }
}
