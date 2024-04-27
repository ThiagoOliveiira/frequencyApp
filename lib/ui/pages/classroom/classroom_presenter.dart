import 'package:get/get.dart';

import '../../../domain/domain.dart';

abstract class ClassroomPresenter {
  Rx<List<AulaEntity>?> get aulaEntity;
  Rx<AccountEntity?> get accountEntity;
  Rx<List<AulaEntity>?> get classNotClosed;
  Rx<List<AulaEntity>?> get classClosed;
  Rx<List<StudentFrequencyEntity?>?> get frequencyClass;

  RxBool get isLoading;

  Future<void> startClass(AulaEntity? aulaEntity);
  Future<void> endClass(AulaEntity? aulaEntity);
  Future<void> getStudentFrequencyList(int? idAula);
}
