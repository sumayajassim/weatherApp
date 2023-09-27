import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'location.dart';
import 'networking.dart';

class Weather {
  String? apiKey = dotenv.env['API_KEY'];

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    var weatherData_ = WeatherData.fromMap(weatherData);
    print('weatherData ${weatherData_}');
    return weatherData_;
  }

  Future<dynamic> getWeatherByCityName(city) async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    var weatherData_ = WeatherData.fromMap(weatherData);
    return weatherData_;
  }
}

class WeatherData {
  int temperature;
  int? humidity;
  int minTemperature;
  int maxTemperature;
  int? feelsLike;
  String description;
  DateTime? sunrise;
  DateTime? sunset;
  String city;
  String icon;

  WeatherData({
    required this.temperature,
    this.humidity,
    required this.minTemperature,
    required this.maxTemperature,
    this.feelsLike,
    this.sunrise,
    this.sunset,
    required this.city,
    required this.description,
    required this.icon,
  });

  factory WeatherData.fromMap(Map<String, dynamic> weatherData) {
    var temperature = _toDoubleAsInt(weatherData['main']['temp']);
    var humidity = weatherData['main']['humidity'];
    var minTemperature = _toDoubleAsInt(weatherData['main']['temp_min']);
    var maxTemperature = _toDoubleAsInt(weatherData['main']['temp_max']);
    var feelsLike = _toDoubleAsInt(weatherData['main']['feels_like']);
    var sunriseTimeStamp = weatherData['sys']['sunrise'];
    var sunsetTimeStamp = weatherData['sys']['sunset'];
    var cityName = weatherData['name'];
    var icon =
        'https://openweathermap.org/img/wn/${weatherData['weather'][0]['icon']}@2x.png';
    var description = weatherData['weather'][0]['description'];
    DateTime sunriseDateTime =
        DateTime.fromMillisecondsSinceEpoch(sunriseTimeStamp * 1000);
    DateTime sunsetDateTime =
        DateTime.fromMillisecondsSinceEpoch(sunsetTimeStamp * 1000);

    return WeatherData(
        temperature: temperature,
        humidity: humidity,
        minTemperature: minTemperature,
        maxTemperature: maxTemperature,
        feelsLike: feelsLike,
        sunrise: sunriseDateTime,
        sunset: sunsetDateTime,
        description: description,
        city: cityName,
        icon: icon);
  }

  static int _toDoubleAsInt(double value) {
    return value.round();
  }

  @override
  String toString() {
    return 'WeatherData: Temperature=$temperature, Humidity=$humidity, MinTemperature=$minTemperature, MaxTemperature=$maxTemperature, FeelsLike=$feelsLike, Sunrise=$sunrise, Sunset=$sunset, Icon=$icon';
  }
}
