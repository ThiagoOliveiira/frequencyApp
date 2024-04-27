import 'package:get/get.dart';

import '../../domain/domain.dart';
import '../../ui/ui.dart';
import '../presentation.dart';

class GetxLoginPresenter extends GetxController with LoadingManager, UIErrorManagerPresenter, FormManager implements LoginPresenter {
  final Validation validation;
  final Authentication authentication;
  final SaveCurrentAccount saveCurrentAccount;

  GetxLoginPresenter({required this.authentication, required this.validation, required this.saveCurrentAccount});

  String? _registration;
  String? _password;

  @override
  Rxn<UIError?> registrationError = Rxn<UIError?>();

  @override
  Rxn<UIError?> passwordError = Rxn<UIError?>();

  @override
  void validateRegistration(String matricula) {
    _registration = matricula;
    registrationError.value = _validateField('registration');
    _validateForm();
  }

  @override
  void validatePassword(String senha) {
    _password = senha;
    passwordError.value = _validateField('password');
    _validateForm();
  }

  UIError? _validateField(String field) {
    final formData = {'registration': _registration, 'password': _password};
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

  void _validateForm() => setFormValid = registrationError.value == null && passwordError.value == null && _registration != null && _password != null;

  @override
  Future<void> auth() async {
    try {
      isSetLoading = true;
      if (_registration?.isNotEmpty == true && _password?.isNotEmpty == true) {
        final account = await authentication.auth(AuthenticationParams(matricula: int.parse(_registration!), senha: _password!));
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
