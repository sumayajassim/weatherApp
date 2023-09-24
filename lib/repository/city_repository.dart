import 'package:postgres/postgres.dart';
import 'package:weather_app/models/city.dart';
import 'package:weather_app/repository/database.dart';

class CityRepository {
  final databaseConnection = DatabaseConnection();

  Future<List<City>> getCityList() async {
    final connection = databaseConnection.connection;

    try {
      await connection.open();
      final results = await connection.query('SELECT * FROM cities');
      final List<City> cities = results
          .map((row) => City(
                id: row[0] as int,
                name: row[1] as String,
              ))
          .toList();
      print(cities);
      return cities;
    } catch (e) {
      print('Error fetching cities: $e');
      throw Exception('Failed to fetch cities');
    } finally {
      connection.close();
    }
  }

  Future<void> addCity(City city) async {
    final connection = databaseConnection.connection;
    try {
      await connection.open();
      await connection.query(
        'INSERT INTO cities (name) VALUES (@name)',
        substitutionValues: {
          'name': city.name,
        },
      );
      print('City added successfully!');
    } catch (e) {
      print('Error adding city: $e');
      throw Exception('Failed to add city');
    }
  }
}
