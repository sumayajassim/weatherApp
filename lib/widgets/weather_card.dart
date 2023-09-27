import 'package:flutter/material.dart';
import 'package:weather_app/services/weather.dart';

class WeatherCard extends StatefulWidget {
  final dynamic weatherData;
  WeatherCard({this.weatherData});

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  int temperature = 0;
  String description = '';
  String city = '';
  int minTemp = 0;
  int maxTemp = 0;
  String icon = '';

  @override
  void initState() {
    updateUI(widget.weatherData);
    super.initState();
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      temperature = weatherData.temperature;
      minTemp = weatherData.minTemperature;
      maxTemp = weatherData.maxTemperature;
      city = weatherData.city;
      description = weatherData.description;
      icon = weatherData.icon;
    });
  }

  // weatherData(widget.weatherData);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 200,
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(icon),
                Text(
                  city,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(description!),
              ],
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                '$temperature°C',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  '$minTemp°C',
                  style: const TextStyle(
                      // fontWeight: FontWeight.bold,
                      ),
                ),
                Text('$maxTemp°C')
              ]),
            ]),
          ],
        ),
      ),
    );
  }
}
