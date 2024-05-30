// In weather_page.dart

import 'package:flutter/material.dart';
import 'package:project/module/weather_mode.dart';
import 'package:project/service/weather_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('d34f0f549e81cb5095d21303c5119c55');
  Weather? _weather;
  String _errorMessage = '';

  Future<void> _checkPermissions() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      _fetchWeather();
    } else if (status.isDenied) {
      setState(() {
        _errorMessage = 'Location permission denied';
      });
    } else if (status.isPermanentlyDenied) {
      setState(() {
        _errorMessage = 'Location permission permanently denied';
      });
    }
  }

  Future<void> _fetchWeather() async {
    setState(() {
      _errorMessage = '';
    });
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      final weather = await _weatherService.getWeatherByCoordinates(
        position.latitude,
        position.longitude,
      );
      setState(() {
        _weather = weather;
      });
    } on PermissionDeniedException catch (e) {
      setState(() {
        _errorMessage = 'Location permission denied: ${e.toString()}';
      });
    } on LocationServiceDisabledException catch (e) {
      setState(() {
        _errorMessage = 'Location services disabled: ${e.toString()}';
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
    _checkPermissions();
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
