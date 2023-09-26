import 'package:get/get.dart';

mixin LoadingManager on GetxController {
  final _isLoading = false.obs;
  RxBool get isLoading => _isLoading;
  set isSetLoading(bool value) => _isLoading.value = value;
}
