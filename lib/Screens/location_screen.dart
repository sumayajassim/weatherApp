import 'package:flutter/material.dart';
import 'package:weather_app/Screens/cities_screen.dart';
import 'package:weather_app/Screens/search_screen.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:intl/intl.dart';

import '../utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  final dynamic locationWeather;
  LocationScreen({this.locationWeather});

  @override
  State<LocationScreen> createState() => _GetWeatherState();
}

class _GetWeatherState extends State<LocationScreen> {
  int temperature = 0;
  int humidity = 0;
  String description = '';
  String city = '';
  String sunrise = '';
  String sunset = '';
  int feelsLike = 0;
  int minTemp = 0;
  int maxTemp = 0;
  String icon = '';

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      temperature = weatherData.temperature;
      humidity = weatherData.humidity;
      minTemp = weatherData.minTemperature;
      maxTemp = weatherData.maxTemperature;
      city = weatherData.city;
      sunrise = DateFormat('HH:mm').format(weatherData.sunrise);
      sunrise = DateFormat('HH:mm').format(weatherData.sunset);
      feelsLike = weatherData.feelsLike;
      description = weatherData.description;
      icon = weatherData.icon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
                  EdgeInsets.only(top: 20.0), // Optional padding for spacing
              child: IconButton(
                icon: Icon(Icons.list),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CitiesScreen()));
                },
              ),
            ),
            Image.network(icon),
            Text(
              '$temperature°C',
              style:
                  const TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            Text(
              description,
              style: const TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                const Icon(
                  WeatherIcons.humidity,
                  size: 24.0,
                ),
                const SizedBox(width: 8.0),
                Text('Humidity: $humidity%'),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                const Icon(
                  WeatherIcons.sunrise,
                  size: 24.0,
                ),
                const SizedBox(width: 8.0),
                Text('Sunrise: $sunrise'),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                const Icon(
                  WeatherIcons.sunset,
                  size: 24.0,
                ),
                const SizedBox(width: 8.0),
                Text('Sunset: $sunset'),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                const Icon(
                  WeatherIcons.thermometer,
                  size: 24.0,
                ),
                const SizedBox(width: 8.0),
                Text('Feels like: $feelsLike'),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                const Icon(
                  WeatherIcons.thermometer_exterior,
                  size: 24.0,
                ),
                const SizedBox(width: 8.0),
                Text('Min: $minTemp'),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                const Icon(
                  WeatherIcons.thermometer_internal,
                  size: 24.0,
                ),
                const SizedBox(width: 8.0),
                Text('Max: $maxTemp'),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                const Icon(
                  WeatherIcons.celsius,
                  size: 24.0,
                ),
                const SizedBox(width: 8.0),
                Text('Country: $city'),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
    );
  }
}
