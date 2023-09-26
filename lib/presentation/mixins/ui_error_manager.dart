import 'package:get/get.dart';

import '../../domain/domain.dart';
import '../../ui/helpers/helpers.dart';

mixin UIErrorManagerPresenter on GetxController {
  final _mainError = Rxn<UIError?>(null);
  Rxn<UIError?> get mainError => _mainError;
  set isSetMainError(UIError? value) => _mainError.value = value;

  UIError handleDomainError(DomainError domainError) {
    switch (domainError) {
      case DomainError.invalidCredentials:
        return UIError.invalidCredentials;
      case DomainError.emailInUse:
        return UIError.emailInUse;
      default:
        return UIError.unexpected;
    }
  }
}
