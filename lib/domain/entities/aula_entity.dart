import 'package:equatable/equatable.dart';

class AulaEntity extends Equatable {
  final int? id;
  final bool? finalizada;
  final String? codigoAula;
  final String? latitude;
  final String? longitude;
  final DateTime? dataAula;
  final int? idCurso;
  final String? nomeCurso;
  final int? idDisciplina;
  final String? nomeDisciplina;

  const AulaEntity({
    required this.id,
    required this.codigoAula,
    required this.latitude,
    required this.longitude,
    required this.dataAula,
    required this.idCurso,
    required this.nomeCurso,
    required this.idDisciplina,
    required this.nomeDisciplina,
    required this.finalizada,
  });

  static Map<String, dynamic> toMapDynamic(List<dynamic>? aulaEntity) => {
        "id": aulaEntity?.first,
        "finalizada": aulaEntity?[1],
        "codigoAula": aulaEntity?[2],
        "latitude": aulaEntity?[3],
        "longitude": aulaEntity?[4],
        "dataAula": aulaEntity?[5],
        "idCurso": aulaEntity?[6],
        "nomeCurso": aulaEntity?[7],
        "idDisciplina": aulaEntity?[8],
        "nomeDisciplina": aulaEntity?[9],
      };

  static Map<String, dynamic> toMap(AulaEntity aulaEntity) => {
        "id": aulaEntity.id,
        "codigoAula": aulaEntity.codigoAula,
        "latitude": aulaEntity.latitude,
        "longitude": aulaEntity.longitude,
        "dataAula": aulaEntity.dataAula,
        "idCurso": aulaEntity.idCurso,
        "nomeCurso": aulaEntity.nomeCurso,
        "idDisciplina": aulaEntity.idDisciplina,
        "nomeDisciplina": aulaEntity.nomeDisciplina,
        "finalizada": aulaEntity.finalizada,
      };

  @override
  List get props => [id, codigoAula, latitude, longitude, dataAula, idCurso, nomeCurso, idDisciplina, nomeDisciplina, finalizada];
}
