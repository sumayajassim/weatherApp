import 'package:postgres/postgres.dart';

class DatabaseConnection {
  late PostgreSQLConnection _connection;

  DatabaseConnection({
    String host = '127.0.0.1',
    int port = 5432,
    String databaseName = 'weatherApp',
    String username = 'postgres',
    String password = 'sumaya',
  }) {
    _connection = PostgreSQLConnection(
      host,
      port,
      databaseName,
      username: username,
      password: password,
    );
  }
  PostgreSQLConnection get connection => _connection;
}
