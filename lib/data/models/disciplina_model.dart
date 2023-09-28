import '../../domain/domain.dart';

class DisciplinaModel {
  final int id;
  final String descricao;

  const DisciplinaModel({required this.id, required this.descricao});

  factory DisciplinaModel.fromJson(Map json) {
    return DisciplinaModel(
      id: json['id'],
      descricao: json['descricao'],
    );
  }

  DisciplinaEntity toEntity() => DisciplinaEntity(id: id, descricao: descricao);
}
