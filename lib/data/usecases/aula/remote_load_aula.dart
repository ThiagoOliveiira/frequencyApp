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
          "select a.id, a.finalizada, a.codigo_aula, a.latitude, a.longitude, a.data_aula, a.id_curso, c.curso, a.id_disciplina, d.disciplina, a.iniciada, a.id_professor, u.nome from aula a inner join curso c ON c.id = a.id_curso inner join disciplina d on d.id = a.id_disciplina inner join usuario u ON u.id = a.id_professor where a.id_professor = @oIdProfessor";

      final httpResponse = await getDatabase.get(query: select, substitutionValues: {"oIdProfessor": id});

      final resultJson = httpResponse.map((e) => AulaEntity.toMapDynamic(e)).toList();

      return resultJson.map<AulaEntity>((result) => AulaModel.fromJson(result).toEntity()).toList();
    } catch (error) {
      throw error == HttpError.unauthorized ? DomainError.invalidCredentials : DomainError.unexpected;
    }
  }

  @override
  Future<void> startClass(AulaEntity aulaEntity) async {
    try {
      String select = "UPDATE public.aula SET latitude=@aLatitude, longitude=@aLongitude, iniciada=@aulaIniciada, nome_bluetooth=@nomeBluetooth WHERE id=@idAula";

      await postDatabase.post(query: select, substitutionValues: {
        'aLatitude': aulaEntity.latitude,
        'aLongitude': aulaEntity.longitude,
        'aulaIniciada': aulaEntity.iniciada,
        'idAula': aulaEntity.id,
        'nomeBluetooth': aulaEntity.nomeBluetooth
      });
    } catch (_) {}
  }

  @override
  Future<void> endClass(AulaEntity aulaEntity) async {
    try {
      String select = "UPDATE public.aula SET finalizada=@aulaFinalizada WHERE id=@idAula";

      await postDatabase.post(query: select, substitutionValues: {'aulaFinalizada': aulaEntity.finalizada, 'idAula': aulaEntity.id});
    } catch (error) {
      throw error == HttpError.unauthorized ? DomainError.invalidCredentials : DomainError.unexpected;
    }
  }

  @override
  Future<AulaEntity?> getClassByCode(String codeClass, int alunoId) async {
    try {
      String select =
          "select a.id, a.finalizada, a.codigo_aula, a.latitude, a.longitude, a.data_aula, a.id_curso, c.curso, a.id_disciplina,d.disciplina, a.iniciada, a.id_professor, a.nome_bluetooth, (select us.nome from usuario us inner join aula au on us.id = au.id_professor where au.codigo_aula ilike @oCodeClass) from aula a inner join curso c ON c.id = a.id_curso inner join disciplina d on d.id = a.id_disciplina inner join usuario u ON u.id_curso  = a.id_curso where u.id = @alunoId and a.codigo_aula ilike @oCodeClass and (a.iniciada = true and a.iniciada notnull) and (a.finalizada = false or a.finalizada isnull)";
      final httpResponse = await getDatabase.get(query: select, substitutionValues: {"oCodeClass": codeClass, "alunoId": alunoId});
      if (httpResponse == null) {
        return null;
      }

      final resultJson = httpResponse.map((e) => AulaEntity.toMapDynamic(e)).toList();

      return AulaModel.fromJson(resultJson.first).toEntity();
    } catch (error) {
      throw error == HttpError.unauthorized ? DomainError.invalidCredentials : DomainError.unexpected;
    }
  }

  @override
  Future<void> confirmPresence(FrequencyEntity? frequencyEntity) async {
    try {
      String select =
          // "select a.id, a.finalizada, a.codigo_aula, a.latitude, a.longitude, a.data_aula, a.id_curso, c.curso, a.id_disciplina, d.disciplina, a.iniciada, a.id_professor, u.nome from aula a inner join curso c ON c.id = a.id_curso inner join disciplina d on d.id = a.id_disciplina inner join usuario u ON u.id = a.id_professor where a.codigo_aula = @oCodeClass and (a.iniciada = true and a.iniciada notnull) and (a.finalizada = false or a.finalizada isnull)";
          "INSERT INTO public.frequencia (latitude, longitude, data_hora_confirmacao, presente, id_aula, id_aluno) VALUES(@aLatitude, @aLongitude, @aDataAula, @aPresenca, @idAula, @idAluno)";
      await postDatabase.post(query: select, substitutionValues: {
        "aLatitude": frequencyEntity?.latitude,
        "aLongitude": frequencyEntity?.longitude,
        "aDataAula": frequencyEntity?.dataHoraConfirmacao,
        "aPresenca": frequencyEntity?.presente,
        "idAula": frequencyEntity?.idAula,
        "idAluno": frequencyEntity?.idAluno,
      });
    } catch (error) {
      throw error == HttpError.unauthorized ? DomainError.invalidCredentials : DomainError.unexpected;
    }
  }
}
