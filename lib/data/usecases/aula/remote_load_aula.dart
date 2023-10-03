import '../../../domain/domain.dart';
import '../../data.dart';

class RemoteLoadAula implements ClassroomUsecase {
  final GetDatabase getDatabase;
  final PostDatabase postDatabase;

  RemoteLoadAula({required this.postDatabase, required this.getDatabase});

  @override
  Future<List<AulaEntity>?> loadAulaByUsuario(int id) async {
    try {
      String select =
          "select a.id, a.finalizada, a.codigo_aula, a.latitude, a.longitude, a.data_aula, a.id_curso, c.curso, a.id_disciplina, d.disciplina from aula a inner join curso c ON c.id = a.id_curso inner join disciplina d on d.id = a.id_disciplina where a.id_professor = @oIdProfessor";

      final httpResponse = await getDatabase.get(query: select, substitutionValues: {"oIdProfessor": id});

      final resultJson = httpResponse.map((e) => AulaEntity.toMapDynamic(e)).toList();

      return resultJson.map<AulaEntity>((result) => AulaModel.fromJson(result).toEntity()).toList();
    } catch (error) {
      print(error);
      // throw error == HttpError.unauthorized ? DomainError.invalidCredentials : DomainError.unexpected;
    }
  }

  @override
  Future<void> startClass(AulaEntity aulaEntity) async {
    try {
      // String select = "select a.id, a.finalizada, a.codigo_aula, a.latitude, a.longitude, a.data_aula, a.id_curso, c.cuso,
      // a.id_disciplina, d.disciplina from aula a inner join curso c ON c.id = a.id_curso inner join disciplina d on d.id = a.id_disciplina where a.id_professor = @oIdProfessor";

      String select = "UPDATE public.aula SET latitude=@aLatitude, longitude=@aLongitude, iniciada=@aulaIniciada WHERE id=@idAula";

      final httpResponse =
          await postDatabase.post(query: select, substitutionValues: {'aLatitude': aulaEntity.latitude, 'aLongitude': aulaEntity.longitude, 'aulaIniciada': true, 'idAula': aulaEntity.id});
    } catch (error) {
      print(error);
      // throw error == HttpError.unauthorized ? DomainError.invalidCredentials : DomainError.unexpected;
    }
  }
}
