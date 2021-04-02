import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/Models.dart';


class getData{
  Future<WeatherResponse> getWeatherData(String city) async {

    final inputData = {
      'q': city,
      'appid': '6cfbce8d90da5850d4757308bf972c0f',
      'units': 'metric'
    };

    final uri = Uri.http('api.openweathermap.org', '/data/2.5/weather', inputData);

    final result = await http.get(uri);
    print(result.body);
    final json = jsonDecode(result.body);
    return WeatherResponse.fromJson(json);
  }
}