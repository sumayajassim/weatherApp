import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:weather_app/Screens/location_screen.dart';
import 'package:weather_app/models/city.dart';
import 'package:weather_app/repository/city_repository.dart';
import 'package:weather_app/repository/database.dart';
import 'package:weather_app/services/networking.dart';
import 'package:weather_app/services/weather.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late AutoCompleteTextField<dynamic> searchTextField;
  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();

  List<String> cities = [
    'New York',
    'Toronto',
    'London',
    // Add more city names here
  ];
  String selectedCountry = '';
  String selectedCity = '';

  void cityWeather(String item) async {
    searchTextField.textField?.controller?.text = item;
    Weather weather = Weather();
    var weatherData = await weather.getWeatherByCityName(item);
    CityRepository cityRepository = CityRepository();
    City city = City(name: item);
    cityRepository.addCity(city);
    if (!context.mounted) return;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                LocationScreen(locationWeather: weatherData)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Autocomplete Page'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            searchTextField = AutoCompleteTextField<String>(
              key: key,
              clearOnSubmit: false,
              suggestions: cities,
              decoration: const InputDecoration(
                labelText: 'Search',
              ),
              itemFilter: (item, query) =>
                  item.toLowerCase().startsWith(query.toLowerCase()),
              itemSorter: (a, b) => a.compareTo(b),
              itemSubmitted: (item) {
                cityWeather(item);
              },
              itemBuilder: (context, item) {
                return ListTile(
                  title: Text(item),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
