import '../../domain/domain.dart';

class FrequencyModel {
  final int? id;
  final String? latitude;
  final String? longitude;
  final DateTime? dataHoraConfirmacao;
  final bool? presente;
  final int? idAula;
  final int? idAluno;

  const FrequencyModel({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.dataHoraConfirmacao,
    required this.idAluno,
    required this.idAula,
    required this.presente,
  });

  static Map<String, dynamic> toMapDynamic(List<dynamic>? frequency) => {
        "id": frequency?.first,
        "latitude": frequency?[1],
        "longitude": frequency?[2],
        "dataHoraConfirmacao": frequency?[3],
        "presente": frequency?[4],
        "idAula": frequency?[5],
        "idAluno": frequency?[6],
      };

  factory FrequencyModel.fromJson(dynamic json) {
    return FrequencyModel(
      id: json['id'],
      dataHoraConfirmacao: json['dataHoraConfirmacao'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      idAluno: json['idAluno'],
      idAula: json['idAula'],
      presente: json['presente'],
    );
  }

  FrequencyEntity toEntity() => FrequencyEntity(
        id: id,
        latitude: latitude,
        longitude: longitude,
        dataHoraConfirmacao: dataHoraConfirmacao,
        idAluno: idAluno,
        idAula: idAula,
        presente: presente,
      );
}
