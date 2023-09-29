import 'dart:convert';

import '../../domain/domain.dart';

class RemoteAccountModel {
  final int? id;
  final String? matricula;
  final String? nome;
  final String? senha;
  final String? tipo;

  RemoteAccountModel({required this.id, required this.matricula, required this.nome, required this.senha, required this.tipo});

  factory RemoteAccountModel.fromJson(dynamic json) {
    return RemoteAccountModel(
      id: json['id'],
      matricula: json['matricula'],
      nome: json['nome'],
      senha: json['senha'],
      tipo: json['tipo'],
    );
  }

  AccountEntity toEntity() => AccountEntity(id: id, matricula: matricula, senha: senha, nome: nome, tipo: tipo);

  static RemoteAccountModel deserialize(String serial) => RemoteAccountModel.fromJson(jsonDecode(serial));
}
