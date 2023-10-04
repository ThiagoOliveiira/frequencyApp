import 'package:postgres/postgres.dart';

import '../../data/data.dart';
import '../../domain/domain.dart';

class ConnectionDatabaseAdapter implements PostDatabase, GetDatabase {
  final String host;
  final int port;
  final String dbName;
  final String username;
  final String password;

  // ignore: prefer_typing_uninitialized_variables
  var connection;

  ConnectionDatabaseAdapter({required this.host, required this.port, required this.dbName, required this.username, required this.password});

  Future<void> _connectionDB() async {
    try {
      connection = PostgreSQLConnection(host, port, dbName, username: username, password: password, useSSL: true);
      await connection?.open();
    } catch (e) {
      throw DomainError.unexpected;
    }
  }

  @override
  Future<dynamic> post({String? query, dynamic substitutionValues}) async {
    try {
      await _connectionDB();
      print(query);
      dynamic results = await connection.query(query, substitutionValues: substitutionValues);
      print(results);
      return results;
    } catch (e) {
      throw DomainError.unexpected;
    }
  }

  @override
  Future get({String? query, substitutionValues}) async {
    try {
      await _connectionDB();
      dynamic results = await connection.query(query, substitutionValues: substitutionValues);
      print(results);
      return results;
    } catch (e) {
      throw DomainError.unexpected;
    }
  }
}
