import 'package:equatable/equatable.dart';

class FrequencyEntity extends Equatable {
  final int? id;
  final String? latitude;
  final String? longitude;
  final DateTime? dataHoraConfirmacao;
  final bool? presente;
  final int? idAula;
  final int? idAluno;

  const FrequencyEntity({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.dataHoraConfirmacao,
    required this.idAluno,
    required this.idAula,
    required this.presente,
  });

  static Map<String, dynamic> toMapDynamic(List<dynamic>? frequencyEntity) => {
        "id": frequencyEntity?.first,
        "latitude": frequencyEntity?[1],
        "longitude": frequencyEntity?[2],
        "dataHoraConfirmacao": frequencyEntity?[3],
        "presente": frequencyEntity?[4],
        "idAula": frequencyEntity?[5],
        "idAluno": frequencyEntity?[6],
      };

  static Map<String, dynamic> toMap(FrequencyEntity? frequencyEntity) => {
        "id": frequencyEntity?.id,
        "latitude": frequencyEntity?.latitude,
        "longitude": frequencyEntity?.longitude,
        "dataHoraConfirmacao": frequencyEntity?.dataHoraConfirmacao,
        "presente": frequencyEntity?.presente,
        "idAula": frequencyEntity?.idAula,
        "idAluno": frequencyEntity?.idAluno,
      };

  // Copy constructor
  FrequencyEntity.copy(
    FrequencyEntity? original, {
    int? id,
    String? latitude,
    String? longitude,
    DateTime? dataHoraConfirmacao,
    bool? presente,
    int? idAula,
    int? idAluno,
  })  : id = id ?? original?.id,
        latitude = latitude ?? original?.latitude,
        longitude = longitude ?? original?.longitude,
        dataHoraConfirmacao = dataHoraConfirmacao ?? original?.dataHoraConfirmacao,
        presente = presente ?? original?.presente,
        idAula = idAula ?? original?.idAula,
        idAluno = idAluno ?? original?.idAluno;

  @override
  List get props => [id, latitude, longitude, dataHoraConfirmacao, idAula, idAluno, presente];
}
