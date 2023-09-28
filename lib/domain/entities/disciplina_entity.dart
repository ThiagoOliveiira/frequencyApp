import 'package:equatable/equatable.dart';

class DisciplinaEntity extends Equatable {
  final int id;
  final String descricao;

  const DisciplinaEntity({required this.id, required this.descricao});

  @override
  List get props => [id, descricao];

  static Map<String, dynamic> toMap(List<dynamic>? disciplina) => {
        "id": disciplina?.first,
        "descricao": disciplina?.last,
      };
}
