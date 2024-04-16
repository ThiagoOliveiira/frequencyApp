import 'package:get/get.dart';

import '../../domain/domain.dart';
import '../../ui/ui.dart';
import '../presentation.dart';

class GetxLoginPresenter extends GetxController with LoadingManager, UIErrorManagerPresenter, FormManager implements LoginPresenter {
  final Validation validation;
  final Authentication authentication;
  final SaveCurrentAccount saveCurrentAccount;

  GetxLoginPresenter({required this.authentication, required this.validation, required this.saveCurrentAccount});

  String? _matricula;
  String? _senha;

  @override
  Rxn<UIError?> matriculaError = Rxn<UIError?>();

  @override
  Rxn<UIError?> senhaError = Rxn<UIError?>();

  @override
  void validateMatricula(String matricula) {
    _matricula = matricula;
    matriculaError.value = _validateField('matricula');
    _validateForm();
  }

  @override
  void validateSenha(String senha) {
    _senha = senha;
    senhaError.value = _validateField('senha');
    _validateForm();
  }

  UIError? _validateField(String field) {
    final formData = {'matricula': _matricula, 'senha': _senha};
    final error = validation.validate(field: field, input: formData);
    switch (error) {
      case ValidationError.invalidField:
        return UIError.invalidField;
      case ValidationError.requiredField:
        return UIError.requiredField;
      default:
        return null;
    }
  }

  void _validateForm() => setFormValid = matriculaError.value == null && matriculaError.value == null && _matricula != null && _senha != null;

  @override
  Future<void> auth() async {
    try {
      isSetLoading = true;
      if (_matricula?.isNotEmpty == true && _senha?.isNotEmpty == true) {
        final account = await authentication.auth(AuthenticationParams(matricula: int.parse(_matricula!), senha: _senha!));
        await saveCurrentAccount.save(account);
        isSetLoading = false;

        if (account != null) {
          Get.offAndToNamed('/home');
        } else {
          isSetMainError = null;
          isSetMainError = UIError.invalidCredentials;
        }
      }
      isSetLoading = false;
    } on DomainError catch (error) {
      Get.offAndToNamed('/home');
      isSetMainError = null;
      switch (error) {
        case DomainError.invalidCredentials:
          isSetMainError = UIError.invalidCredentials;
          break;
        default:
          isSetMainError = UIError.unexpected;
          break;
      }
      isSetLoading = false;
    }
  }
}
