import 'package:flutter/material.dart';
import 'package:project/module/weather_mode.dart';
import 'package:project/service/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('9de4a0fe9da26f7a0fedfc944406d24d');
  Weather? _weather;
  String _errorMessage = '';

  _fetchWeather() async {
    setState(() {
      _errorMessage = '';
    });
    try {
      String cityName = await _weatherService.getCurrentCity();
      if (cityName.isEmpty) {
        throw Exception('Could not determine the current city.');
      }
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load weather data: ${e.toString()}';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
      ),
      body: Center(
        child: _weather == null && _errorMessage.isEmpty
            ? CircularProgressIndicator()
            : _errorMessage.isNotEmpty
                ? Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red, fontSize: 16),
                    textAlign: TextAlign.center,
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _weather?.cityName ?? 'Unknown City',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        '${_weather?.temperature.round() ?? ''}°C',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blueAccent,
                        ),
                      ),
                      SizedBox(height: 24),
                    ],
                  ),
      ),
    );
  }
}
