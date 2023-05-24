import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app/core/contants/global_variables.dart';
import 'package:weather_app/core/models/city_model.dart';
import 'package:weather_app/core/models/weather_model.dart';
import 'package:http/http.dart' as http;

import '../helper/http_exception.dart';
import '../models/cloud.dart';
import '../models/coord_model.dart';
import '../models/main.dart';
import '../models/sys.dart';
import '../models/weather.dart';
import '../models/wind.dart';

class WeatherProvider extends ChangeNotifier {
  //initiatilization
  WeatherModel weatherModel = WeatherModel(
    coord: Coord(lon: 0, lat: 0),
    weather: [Weather(description: '')],
    base: '',
    main: Main(
        temp: 0,
        feelsLike: 0,
        tempMin: 0,
        tempMax: 0,
        pressure: 0,
        humidity: 0),
    visibility: 0,
    wind: Wind(speed: 0, deg: 0),
    clouds: Clouds(all: 0),
    dt: 0,
    sys: Sys(country: '', sunrise: 0, sunset: 0),
    timezone: 0,
    id: 0,
    name: '',
    cod: 0,
  );

  //getters
  Coord? get coord => weatherModel.coord;
  List<Weather>? get weather => weatherModel.weather;
  String? get base => weatherModel.base;
  Main? get main => weatherModel.main;
  int? get visibility => weatherModel.visibility;
  Wind? get wind => weatherModel.wind;
  Clouds? get clouds => weatherModel.clouds;
  int? get dt => weatherModel.dt;
  Sys? get sys => weatherModel.sys;
  int? get timezone => weatherModel.timezone;
  int? get id => weatherModel.id;
  String? get name => weatherModel.name;
  int? get cod => weatherModel.cod;

  final baseUrl = 'https://api.openweathermap.org';

  Future<void> getCityWeather(
      {String lat = "6.4550", String lon = "3.3841"}) async {
    try {
      final response = await http.get(Uri.parse(
          '$baseUrl/data/2.5/weather?lat=$lat&lon=$lon&appid=${GlobalVariables.apiKey}'));
      if (response.statusCode == 200) {
        final weatherData = json.decode(response.body) as Map<String, dynamic>;

        weatherModel = WeatherModel.fromJson(weatherData);
        print(weatherModel.coord!.lat);
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
      HttpException(message: e.toString());
    }
  }

  // List<CityModel> getProvider(BuildContext context) =>
  //     Provider.of<CityProvider>(context, listen: false).selectedCities;

  // Future<void> getMultipleCityWeather(BuildContext context) async {
  //   try {
  //     for (var city in getProvider(context)) {
  //       final response = await http.get(Uri.parse(
  //           '$baseUrl/data/2.5/weather?lat=${city.lat}&lon=${city.lon}&appid=${GlobalVariables.apiKey}'));
  //       if (response.statusCode == 200) {
  //         final weatherData =
  //             WeatherModel.fromJson(response.body as Map<String, dynamic>);
  //         weatherModel = weatherData;
  //         notifyListeners();
  //       }
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
