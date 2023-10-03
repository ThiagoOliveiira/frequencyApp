import 'dart:convert';

import 'package:equatable/equatable.dart';

class AccountEntity extends Equatable {
  final int? id;
  final int? matricula;
  final String? nome;
  final String? senha;
  final String? tipo;

  @override
  List get props => [id, matricula, senha, nome, tipo];

  static Map<String, dynamic> toMapDynamic(List<dynamic>? userLoggedEntity) => {
        "id": userLoggedEntity?.first,
        "matricula": userLoggedEntity?[1],
        "senha": userLoggedEntity?[2],
        "nome": userLoggedEntity?[3],
        "tipo": userLoggedEntity?[4],
      };

  static Map<String, dynamic> toMap(AccountEntity userLoggedEntity) => {
        "id": userLoggedEntity.id,
        "matricula": userLoggedEntity.matricula,
        "senha": userLoggedEntity.senha,
        "nome": userLoggedEntity.nome,
        "tipo": userLoggedEntity.tipo,
      };

  const AccountEntity({this.matricula, this.nome, this.senha, this.tipo, this.id});

  static String serialize(AccountEntity userLoggedEntity) => jsonEncode(AccountEntity.toMap(userLoggedEntity));
}
