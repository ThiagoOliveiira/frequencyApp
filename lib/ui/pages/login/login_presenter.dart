import 'package:get/get.dart';

import '../../helpers/helpers.dart';

abstract class LoginPresenter {
  Future<void> auth();

  RxBool get isFormValid;
  RxBool get isLoading;

  Rxn<UIError?> get mainError;
  Rxn<UIError?> get registrationError;
  Rxn<UIError?> get passwordError;

  void validateRegistration(String registration);
  void validatePassword(String password);
}
