import 'package:frequency_app/domain/entities/entities.dart';

abstract class ClassroomUsecase {
  Future<List<AulaEntity>?> loadAulaByUsuario(int id);
  Future<void> startClass(AulaEntity aulaEntity);
  Future<void> endClass(AulaEntity aulaEntity);
  Future<AulaEntity?> getClassByCode(String codeClass, int alunoId);
  Future<void> confirmPresence(FrequencyEntity? frequencyEntity);
}
