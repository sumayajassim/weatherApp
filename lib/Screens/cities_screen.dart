import 'package:autocomplete_textfield/autocomplete_textfield.dart';
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
  late AutoCompleteTextField<dynamic> searchTextField;
  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();
  List<WeatherData>? citiesList = [];
  List<String> cities = [
    'New York',
    'Toronto',
    'London',
    'Paris'
    // Add more city names here
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    Weather weather = Weather();

    WeatherData weatherData = await weather.getLocationWeather();
    CityRepository cityRepository = CityRepository();
    citiesList = await cityRepository.getCityList();
    print(citiesList);
    setState(() {
      citiesList!.insert(0, weatherData);
      // citiesList!;
    });
  }

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
          title: const Text('Cities'),
        ),
        body: Column(children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
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
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: citiesList?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                final city = citiesList?[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                LocationScreen(locationWeather: city)));
                  },
                  child: WeatherCard(
                    cityName: city?.city ?? '',
                    temperature: city?.temperature,
                    minTemp: city?.minTemperature,
                    maxTemp: city?.maxTemperature,
                    description: city?.description,
                    icon: city?.icon,
                  ),
                );
              },
            ),
          ),
        ]));
  }
}
