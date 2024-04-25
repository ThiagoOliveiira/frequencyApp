import '../entities/entities.dart';

abstract class LoadStudentFrequency {
  Future<List<StudentFrequencyEntity?>?> getStudentFrequency(int idAula);
}
