import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  final String cityName;
  final int? temperature;
  final String? description;
  final int? minTemp;
  final int? maxTemp;
  final String? icon;

  const WeatherCard(
      {Key? key,
      required this.cityName,
      this.temperature,
      this.minTemp,
      this.maxTemp,
      this.icon,
      this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 150,
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(icon!),
                Text(
                  cityName,
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
