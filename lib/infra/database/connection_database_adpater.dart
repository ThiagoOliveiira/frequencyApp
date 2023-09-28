import 'package:postgres/postgres.dart';

import '../../data/data.dart';
import '../../domain/domain.dart';

class ConnectionDatabaseAdapter implements Connection {
  final String host;
  final int port;
  final String dbName;
  final String username;
  final String password;

  ConnectionDatabaseAdapter({required this.host, required this.port, required this.dbName, required this.username, required this.password});

  @override
  Future<void> connectionDB() async {
    try {
      var connection = PostgreSQLConnection(
        host,
        port,
        dbName,
        username: username,
        password: password,
        useSSL: true,
      );
      print(connection.toString());
      await connection.open();
      List<List<dynamic>> results = await connection.query("SELECT * FROM curso");

      print(results);

      // Mapear a lista de disciplinas para um formato JSON
      final resultJson = results.map((e) => DisciplinaEntity.toMap(e)).toList();
      // final disciplinasJson = results.map((disciplina) {
      //   return {
      //     'id': disciplina[0],
      //     'descricao': disciplina[1],
      //   };
      // }).toList();

      print(results);
      print(resultJson);
    } catch (e) {
      print(e);
    }
  }
}
