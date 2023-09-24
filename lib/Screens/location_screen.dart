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

  @override
  void initState() {
    super.initState();
    print(widget.locationWeather);
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      var temp = weatherData['main']['temp'];
      var humidity_ = weatherData['main']['humidity'];
      var minTemp_ = weatherData['main']['temp_min'];
      var maxTemp_ = weatherData['main']['temp_max'];
      var feelsLike_ = weatherData['main']['feels_like'];
      var sunriseTimeStamp = weatherData['sys']['sunrise'];
      var sunsetTimeStamp = weatherData['sys']['sunset'];
      DateTime sunriseDateTime =
          DateTime.fromMillisecondsSinceEpoch(sunriseTimeStamp * 1000);
      DateTime sunsetDateTime =
          DateTime.fromMillisecondsSinceEpoch(sunsetTimeStamp * 1000);

      temperature = temp.toInt() ?? 0;
      humidity = humidity_.toInt() ?? 0;
      minTemp = minTemp_.toInt() ?? 0;
      maxTemp = maxTemp_.toInt() ?? 0;
      city = weatherData['name'] ?? 0;
      sunrise = DateFormat('HH:mm').format(sunriseDateTime);
      sunset = DateFormat('HH:mm').format(sunsetDateTime);
      feelsLike = feelsLike_.toInt() ?? 0;
      description = weatherData['weather'][0]['description'];
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SearchScreen()));
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
    );
  }
}
