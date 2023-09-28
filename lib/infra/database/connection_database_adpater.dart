import 'package:postgres/postgres.dart';

import '../../data/data.dart';

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
    } catch (e) {
      print(e);
    }
  }
}
