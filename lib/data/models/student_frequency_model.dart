import '../../domain/domain.dart';

class StudentFrequencyModel {
  final int? id;
  final int? idAluno;
  final bool? presente;
  final int? matricula;
  final String? nomeAluno;
  final DateTime? dataHoraConfirmacao;
  final int? idAula;
  final String? latitude;
  final String? longitude;

  const StudentFrequencyModel({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.dataHoraConfirmacao,
    required this.idAluno,
    required this.idAula,
    required this.presente,
    required this.matricula,
    required this.nomeAluno,
  });

  static Map<String, dynamic> toMapDynamic(List<dynamic>? frequencyEntity) => {
        "id": frequencyEntity?.first,
        "id_aluno": frequencyEntity?[1],
        "presente": frequencyEntity?[2],
        "matricula": frequencyEntity?[3],
        "nome": frequencyEntity?[4],
        "dataHoraConfirmacao": frequencyEntity?[5],
        "idAula": frequencyEntity?[6],
        "latitude": frequencyEntity?[7],
        "longitude": frequencyEntity?[8],
      };

  factory StudentFrequencyModel.fromJson(dynamic json) {
    return StudentFrequencyModel(
      id: json['id'],
      dataHoraConfirmacao: json['dataHoraConfirmacao'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      idAluno: json['idAluno'],
      idAula: json['idAula'],
      presente: json['presente'],
      matricula: json['matricula'],
      nomeAluno: json['nomeAluno'],
    );
  }

  StudentFrequencyEntity toEntity() => StudentFrequencyEntity(
        id: id,
        latitude: latitude,
        longitude: longitude,
        dataHoraConfirmacao: dataHoraConfirmacao,
        idAluno: idAluno,
        idAula: idAula,
        presente: presente,
        matricula: matricula,
        nomeAluno: nomeAluno,
      );
}
