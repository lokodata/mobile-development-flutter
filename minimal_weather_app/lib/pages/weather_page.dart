import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:minimal_weather_app/models/weather_model.dart';
import 'package:minimal_weather_app/services/weather_service.dart';
import 'package:logger/logger.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final logger = Logger();

  // api key
  final _weatherService =
      WeatherService(apiKey: 'd347fee4f88d96f7de6447f83235076d');
  Weather? _weather;

  // fetch weather
  _fetchWeather() async {
    // get the current city
    String cityName = await _weatherService.getCurrentCity();

    // get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

    // any erros
    catch (e) {
      logger.e(e.toString());
    }
  }

  // weather animations
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition) {
      case 'Clouds':
        return 'assets/cloudy.json';
      case 'Mist':
      case 'Smoke':
      case 'Haze':
      case 'Dust':
      case 'Fog':
        return 'assets/cloudy.json';
      case 'Rain':
        return 'assets/rainy.json';
      case 'Drizzle':
        return 'assets/rainy.json';
      case 'Shower rain':
        return 'assets/rainy.json';
      case 'Thunderstorm':
        return 'assets/stormy.json';
      case 'Clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  // init state
  @override
  void initState() {
    super.initState();

    // fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // city name
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Column(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Color.fromARGB(255, 255, 255, 255),
                    size: 20,
                  ),
                  Text(
                    _weather?.cityName.toUpperCase() ??
                        "loading city..".toUpperCase(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            // animation
            Column(
              children: [
                Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
              ],
            ),

            // temperature
            Padding(
              padding: const EdgeInsets.only(bottom: 25.0),
              child: Column(
                children: [
                  Text(
                    '${_weather?.temperature.round()}°C',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  // weather condition
                  Text(_weather?.mainCondition ?? "",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
