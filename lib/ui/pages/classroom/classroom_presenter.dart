import 'package:get/get.dart';

import '../../../domain/domain.dart';

abstract class ClassroomPresenter {
  Rx<List<AulaEntity>?> get aulaEntity;
  Rx<AccountEntity?> get accountEntity;
  Rx<List<AulaEntity>?> get aulaNotClosed;
  Rx<List<AulaEntity>?> get aulaClosed;

  RxBool get isLoading;

  Future<void> startClass(AulaEntity? aulaEntity);
  Future<void> endClass(AulaEntity? aulaEntity);
}
