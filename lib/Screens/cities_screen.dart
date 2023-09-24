import 'package:flutter/material.dart';
import 'package:weather_app/Screens/location_screen.dart';
import 'package:weather_app/models/city.dart';
import 'package:weather_app/repository/city_repository.dart';
import 'package:weather_app/services/weather.dart';
import 'package:weather_app/widgets/weather_card.dart';

class CitiesScreen extends StatefulWidget {
  const CitiesScreen({Key? key}) : super(key: key);

  @override
  State<CitiesScreen> createState() => _CitiesScreenState();
}

class _CitiesScreenState extends State<CitiesScreen> {
  List<City>? citiesList = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    Weather weather = Weather();

    var weatherData = await weather.getLocationWeather();
    CityRepository cityRepository = CityRepository();
    citiesList = await cityRepository.getCityList();
    City currentLocationCity = City(id: 0, name: '${weatherData['name']}');
    setState(() {
      citiesList!.insert(0, currentLocationCity);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cities'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: citiesList?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          final city = citiesList?[index];
          return WeatherCard(
            cityName: city?.name ?? '',
          );
        },
      ),
    );
  }
}
