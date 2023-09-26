import 'package:get/get.dart';

mixin FormManager on GetxController {
  final _isFormValid = false.obs;
  RxBool get isFormValid => _isFormValid;
  set setFormValid(bool value) => _isFormValid.value = value;
}
