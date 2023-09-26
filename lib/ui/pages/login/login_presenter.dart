import 'package:get/get.dart';

import '../../helpers/helpers.dart';

abstract class LoginPresenter {
  Future<void> auth();

  RxBool get isFormValid;
  RxBool get isLoading;

  Rxn<UIError?> get mainError;
  Rxn<UIError?> get matriculaError;
  Rxn<UIError?> get senhaError;

  void validateMatricula(String matricula);
  void validateSenha(String senha);
}
