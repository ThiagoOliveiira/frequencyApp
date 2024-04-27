import 'package:get/get.dart';

import '../../../domain/domain.dart';
import '../../ui.dart';

abstract class HomePresenter {
  Rx<UserType?> get userType;
  Rx<AccountEntity?> get accountEntity;
  Rx<AulaEntity?> get classroomEntity;
  Rx<List<AulaEntity>?> get classes;

  Rxn<UIError?> get mainError;
  Rxn<UIError?> get codeClassError;

  RxInt get currentPageIndex;
  RxBool get isLoading;
  RxBool get isFormValid;

  Future<void> logout();
  void validateCodeClass(String codeClass);
  Future<void> requestClassByCode();
  Future<void> confirmPresence();
  Future<void> startClass(AulaEntity? classroomEntity);
}
