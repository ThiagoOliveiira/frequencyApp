import 'package:frequency_app/domain/domain.dart';

class AulaModel {
  final int? id;
  final String? codigoAula;
  final String? latitude;
  final String? longitude;
  final DateTime? dataAula;
  final int? idCurso;
  final String? nomeCurso;
  final int? idDisciplina;
  final String? nomeDisciplina;
  final bool? finalizada;
  final bool? iniciada;
  final int? idProfessor;
  final String? nomeProfessor;
  final String? nomeBluetooth;

  const AulaModel({
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
        "codigoAula": aulaEntity?[1],
        "latitude": aulaEntity?[2],
        "longitude": aulaEntity?[3],
        "dataAula": aulaEntity?[4],
        "id_curso": aulaEntity?[5],
        "nome_curso": aulaEntity?[6],
        "id_disciplina": aulaEntity?[7],
        "nome_disciplina": aulaEntity?[8],
        "finalizada": aulaEntity?[9],
        "iniciada": aulaEntity?[10],
        "idProfessor": aulaEntity?[11],
        "nomeBluetooth": aulaEntity?[12],
        "nomeProfessor": aulaEntity?.last,
      };

  factory AulaModel.fromJson(dynamic json) {
    return AulaModel(
      id: json['id'],
      codigoAula: json['codigoAula'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      dataAula: json['dataAula'],
      idCurso: json['idCurso'],
      nomeCurso: json['nomeCurso'],
      idDisciplina: json['idDisciplina'],
      nomeDisciplina: json['nomeDisciplina'],
      finalizada: json['finalizada'],
      iniciada: json['iniciada'],
      idProfessor: json['idProfessor'],
      nomeProfessor: json['nomeProfessor'],
      nomeBluetooth: json['nomeBluetooth'],
    );
  }

  AulaEntity toEntity() => AulaEntity(
        id: id,
        codigoAula: codigoAula,
        latitude: latitude,
        longitude: longitude,
        dataAula: dataAula,
        idCurso: idCurso,
        nomeCurso: nomeCurso,
        idDisciplina: idDisciplina,
        nomeDisciplina: nomeDisciplina,
        finalizada: finalizada,
        iniciada: iniciada,
        idProfessor: idProfessor,
        nomeProfessor: nomeProfessor,
        nomeBluetooth: nomeBluetooth,
      );
}
