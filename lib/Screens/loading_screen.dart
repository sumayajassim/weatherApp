import 'dart:io';
import 'package:flutter/material.dart';
import 'package:weather_app/Screens/location_screen.dart';
import 'package:weather_app/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _GetStartedState();
}

class _GetStartedState extends State<LoadingScreen> {
  Weather weather = Weather();
  @override
  void initState() {
    getLocationWeather();
    super.initState();
  }

  getLocationWeather() async {
    var weatherData = await weather.getLocationWeather();
    if (!context.mounted) return;
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                LocationScreen(locationWeather: weatherData)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
          backgroundColor: Colors.grey,
          strokeWidth: 4.0,
        ),
        // child: Column(
        //   children: <Widget>[
        //     Image.asset('images/weatherIcon.jpg'),
        //     Text(
        //       "Discover the Weather in Your City",
        //       style: Theme.of(context).textTheme.titleLarge,
        //     ),
        // ElevatedButton(
        //   onPressed: () {
        //     // getLocation();
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => const GetWeather()),
        //     );
        //   },
        //   child: const Text('Get Started'),
        // ),
        // ],
      ),
    );
  }
}


  // double temperature = decodedData['main']['temp'];
  //     int condition = decodedData['weather'][0]['id'];
  //     String cityName = decodedData['name'];


