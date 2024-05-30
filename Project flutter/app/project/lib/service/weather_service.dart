// weather_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project/module/weather_mode.dart';

class WeatherService {
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeatherByCoordinates(double lat, double lon) async {
    final response = await http.get(
        Uri.parse('$BASE_URL?lat=$lat&lon=$lon&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
