import 'package:postgres/postgres.dart';

import '../../data/data.dart';
import '../../domain/domain.dart';

class ConnectionDatabaseAdapter implements PostDatabase {
  final String host;
  final int port;
  final String dbName;
  final String username;
  final String password;

  var connection;

  ConnectionDatabaseAdapter({required this.host, required this.port, required this.dbName, required this.username, required this.password});
  @override
  Future<void> _connectionDB() async {
    try {
      connection = PostgreSQLConnection(host, port, dbName, username: username, password: password, useSSL: true);
      await connection.open();
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<dynamic> post({String? query, dynamic substitutionValues}) async {
    try {
      await _connectionDB();

      print(substitutionValues);
      // query = 'SELECT * FROM USUARIO WHERE matricula = @aMatricula and senha = @aSenha';
      // substitutionValues = {"aMatricula": 12345678, "aSenha": 'senha098'};

      dynamic results = await connection.query(query, substitutionValues: substitutionValues);

      print(results);

      return results;

      // final resultJson = results.map((e) => DisciplinaEntity.toMap(e)).toList();

      // print(results);
      // print(resultJson);
    } catch (e) {
      print(e);
    }
  }
}
