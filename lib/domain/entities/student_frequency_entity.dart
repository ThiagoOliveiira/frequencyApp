import 'package:equatable/equatable.dart';

class StudentFrequencyEntity extends Equatable {
  final int? id;
  final int? idAluno;
  final bool? presente;
  final int? matricula;
  final String? nomeAluno;
  final DateTime? dataHoraConfirmacao;
  final int? idAula;
  final String? latitude;
  final String? longitude;

  const StudentFrequencyEntity({
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

  static Map<String, dynamic> toMap(StudentFrequencyEntity? frequencyEntity) => {
        "id": frequencyEntity?.id,
        "idAluno": frequencyEntity?.idAluno,
        "dataHoraConfirmacao": frequencyEntity?.dataHoraConfirmacao,
        "presente": frequencyEntity?.presente,
        "idAula": frequencyEntity?.idAula,
        "matricula": frequencyEntity?.matricula,
        "nome": frequencyEntity?.nomeAluno,
        "latitude": frequencyEntity?.latitude,
        "longitude": frequencyEntity?.longitude,
      };

  // Copy constructor
  // FrequencyEntity.copy(
  //   FrequencyEntity? original, {
  //   int? id,
  //   String? latitude,
  //   String? longitude,
  //   DateTime? dataHoraConfirmacao,
  //   bool? presente,
  //   int? idAula,
  //   int? idAluno,
  // })  : id = id ?? original?.id,
  //       latitude = latitude ?? original?.latitude,
  //       longitude = longitude ?? original?.longitude,
  //       dataHoraConfirmacao = dataHoraConfirmacao ?? original?.dataHoraConfirmacao,
  //       presente = presente ?? original?.presente,
  //       idAula = idAula ?? original?.idAula,
  //       idAluno = idAluno ?? original?.idAluno;

  @override
  List get props => [id, latitude, longitude, dataHoraConfirmacao, idAula, idAluno, presente, matricula, nomeAluno];
}
