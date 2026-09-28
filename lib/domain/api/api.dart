import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../json_convertors/coord.dart';
import '../json_convertors/weather_data.dart';

abstract class Api {
  static final _client = HttpClient();

  static const scheme = 'https';
  static const host = 'api.openweathermap.org';

  // Пока true = приложение использует старые JSON-данные.
  // API вообще не вызывается.
  static const bool demoMode = true;

  static String? get apiKey {
    final key = dotenv.env['API_KEY'];

    if (key == null || key.trim().isEmpty) {
      return null;
    }

    return key;
  }

  // Получение координат
  static Future<Coord> getCoords({
    String cityName = 'Tashkent',
  }) async {
    // DEMO MODE
    if (demoMode) {
      return _loadDemoCoords();
    }

    // Если API key отсутствует
    if (apiKey == null) {
      print('API key not found. Using demo coordinates.');
      return _loadDemoCoords();
    }

    try {
      const path = 'data/2.5/weather';

      final url = Uri(
        scheme: scheme,
        host: host,
        path: path,
        queryParameters: {
          'q': cityName,
          'appid': apiKey!,
          'lang': 'ru',
        },
      );

      final data = await _jsonRequest(url);

      return Coord.fromJson(data);
    } catch (e) {
      print('Could not load live coordinates: $e');
      print('Using demo coordinates.');

      return _loadDemoCoords();
    }
  }

  // Получение погоды
  static Future<WeatherData?> getWeather(Coord? coord) async {
    // DEMO MODE
    if (demoMode) {
      return _loadDemoWeather();
    }

    // Если нет ключа или координат
    if (apiKey == null || coord == null) {
      print('Live API unavailable. Using demo weather.');
      return _loadDemoWeather();
    }

    try {
      // One Call 3.0.
      // Требует доступ к One Call API.
      const weatherPath = 'data/3.0/onecall';

      final url = Uri(
        scheme: scheme,
        host: host,
        path: weatherPath,
        queryParameters: {
          'lat': coord.lat.toString(),
          'lon': coord.lon.toString(),
          'exclude': 'hourly,minutely',
          'appid': apiKey!,
          'lang': 'ru',
        },
      );

      final data = await _jsonRequest(url);

      return WeatherData.fromJson(data);
    } catch (e) {
      print('Could not load live weather: $e');
      print('Using demo weather data.');

      return _loadDemoWeather();
    }
  }

  // Обычный HTTP request
  static Future<Map<String, dynamic>> _jsonRequest(Uri url) async {
    final request = await _client.getUrl(url);
    final response = await request.close();

    final responseBody =
        await response.transform(utf8.decoder).join();

    print('STATUS: ${response.statusCode}');

    if (response.statusCode != 200) {
      throw Exception(
        'OpenWeather error ${response.statusCode}',
      );
    }

    return jsonDecode(responseBody) as Map<String, dynamic>;
  }

  // Берём старые координаты из JSON
  static Future<Coord> _loadDemoCoords() async {
    final jsonString = await rootBundle.loadString(
      'assets/demo/coord.json',
    );

    final data =
        jsonDecode(jsonString) as Map<String, dynamic>;

    return Coord.fromJson(data);
  }

  // Берём старую погоду из JSON
  static Future<WeatherData> _loadDemoWeather() async {
    final jsonString = await rootBundle.loadString(
      'assets/demo/weather_data.json',
    );

    final data =
        jsonDecode(jsonString) as Map<String, dynamic>;

    return WeatherData.fromJson(data);
  }
}