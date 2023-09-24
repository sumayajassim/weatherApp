import 'package:postgres/postgres.dart';
import 'package:weather_app/repository/database.dart';

Future<void> main() async {
  final databaseConnection = DatabaseConnection();

  try {
    // Execute the SELECT query to fetch users
    await databaseConnection.connectToDatabase();
    final connection = databaseConnection.connection;
    await connection.execute('''
      CREATE TABLE cities (
        id SERIAL PRIMARY KEY,
        name TEXT NOT NULL
      )
    ''');

    print('Table "cities" created successfully.');
  } catch (e) {
    print('Error fetching cities: $e');
  }
}
