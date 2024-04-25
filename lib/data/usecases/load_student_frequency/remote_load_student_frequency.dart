import '../../../domain/domain.dart';
import '../../data.dart';

class RemoteLoadStudentFrequency implements LoadStudentFrequency {
  final GetDatabase getDatabase;

  const RemoteLoadStudentFrequency({required this.getDatabase});

  @override
  Future<List<StudentFrequencyEntity?>?> getStudentFrequency(int idAula) async {
    try {
      String select =
          "select f.id, u.id as id_aluno, f.presente, u.matricula, u.nome, f.data_hora_confirmacao, f.id_aula, f.latitude, f.longitude  from frequencia f inner join usuario u on u.id = f.id_aluno where id_aula = @oIdAula";
      final httpResponse = await getDatabase.get(query: select, substitutionValues: {"oIdAula": idAula});

      final resultJson = httpResponse.map((e) => StudentFrequencyEntity.toMapDynamic(e)).toList();

      print(resultJson);

      return resultJson.map<StudentFrequencyEntity>((result) => StudentFrequencyModel.fromJson(result).toEntity()).toList();
    } catch (error) {
      throw error == HttpError.unauthorized ? DomainError.invalidCredentials : DomainError.unexpected;
    }
  }
}
