import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

import '../../../domain/domain.dart';
import '../../ui.dart';

abstract class HomePresenter {
  Rx<UserType?> get userType;
  Rx<AccountEntity?> get accountEntity;
  Rx<AulaEntity?> get aulaEntity;
  Rx<List<AulaEntity>?> get aulas;

  Rxn<UIError?> get mainError;
  Rxn<UIError?> get codeClassError;

  RxInt get currentPageIndex;
  RxBool get isLoading;
  RxBool get isFormValid;
  Stream<List<ScanResult>> get scanResults;

  Future<void> logout();
  void validateCodeClass(String codeClass);
  Future<void> requestClassByCode();
  Future<void> confirmPresence();
  Future<void> startClass(AulaEntity? aulaEntity);
  Future<void> teste();
}
