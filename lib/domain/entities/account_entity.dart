import 'package:equatable/equatable.dart';

class AccountEntity extends Equatable {
  final int? id;
  final String? matricula;
  final String? nome;
  final String? senha;
  final String? tipo;

  @override
  List get props => [id, matricula, senha, nome, tipo];

  static Map<String, dynamic> toMap(List<dynamic>? disciplina) => {
        "id": disciplina?.first,
        "matricula": disciplina?[1],
        "senha": disciplina?[2],
        "nome": disciplina?[3],
        "tipo": disciplina?[4],
      };

  const AccountEntity({
    this.matricula,
    this.nome,
    this.senha,
    this.tipo,
    this.id,
  });
}
