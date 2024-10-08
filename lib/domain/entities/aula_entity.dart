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
  final bool? iniciada;
  final int? idProfessor;
  final String? nomeProfessor;
  final String? nomeBluetooth;

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
    required this.iniciada,
    required this.idProfessor,
    required this.nomeProfessor,
    required this.nomeBluetooth,
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
        "iniciada": aulaEntity?[10],
        "idProfessor": aulaEntity?[11],
        "nomeBluetooth": aulaEntity?[12],
        "nomeProfessor": aulaEntity?.last,
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
        "iniciada": aulaEntity.iniciada,
        "idProfessor": aulaEntity.idProfessor,
        "nomeProfessor": aulaEntity.nomeProfessor,
        "nomeBluetooth": aulaEntity.nomeBluetooth,
      };

  // Copy constructor
  AulaEntity.copy(AulaEntity? original,
      {int? id,
      bool? finalizada,
      String? codigoAula,
      String? latitude,
      String? longitude,
      DateTime? dataAula,
      int? idCurso,
      String? nomeCurso,
      int? idDisciplina,
      String? nomeDisciplina,
      bool? iniciada,
      int? idProfessor,
      String? nomeProfessor,
      String? nomeBluetooth})
      : id = id ?? original?.id,
        finalizada = finalizada ?? original?.finalizada,
        codigoAula = codigoAula ?? original?.codigoAula,
        latitude = latitude ?? original?.latitude,
        longitude = longitude ?? original?.longitude,
        dataAula = dataAula ?? original?.dataAula,
        idCurso = idCurso ?? original?.idCurso,
        nomeCurso = nomeCurso ?? original?.nomeCurso,
        idDisciplina = idDisciplina ?? original?.idDisciplina,
        nomeDisciplina = nomeDisciplina ?? original?.nomeDisciplina,
        iniciada = iniciada ?? original?.iniciada,
        idProfessor = idProfessor ?? original?.idProfessor,
        nomeProfessor = nomeProfessor ?? original?.nomeProfessor,
        nomeBluetooth = nomeBluetooth ?? original?.nomeBluetooth;

  @override
  List get props => [id, codigoAula, latitude, longitude, dataAula, idCurso, nomeCurso, idDisciplina, nomeDisciplina, finalizada, idProfessor, nomeProfessor, nomeBluetooth];
}
