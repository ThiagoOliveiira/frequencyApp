import 'package:get/get.dart';

import '../../../domain/domain.dart';

abstract class ClassroomPresenter {
  Rx<List<AulaEntity>?> get aulaEntity;
  Rx<AccountEntity?> get accountEntity;

  RxBool get isLoading;

  Future<void> startClass(AulaEntity? aulaEntity);
}
