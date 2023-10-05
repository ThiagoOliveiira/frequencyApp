import 'package:frequency_app/domain/entities/entities.dart';

abstract class ClassroomUsecase {
  Future<List<AulaEntity>?> loadAulaByUsuario(int id);
  Future<void> startClass(AulaEntity aulaEntity);
  Future<void> endClass(AulaEntity aulaEntity);
}
