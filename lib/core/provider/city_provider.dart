import 'package:flutter/material.dart';

import '../models/city_model.dart';

class CityProvider extends ChangeNotifier {
  final List<CityModel> _cites = [
    CityModel(city: "Lagos", lat: "6.4550", lon: "3.3841", isSelected: true),
    CityModel(city: "Abuja", lat: "9.0667", lon: "7.4833"),
    CityModel(city: "Ibadan", lat: "7.3964", lon: "3.9167"),
    CityModel(city: "Kano", lat: "12.0000", lon: "8.5167"),
    CityModel(city: "Port Harcourt", lat: "4.8242", lon: "7.0336"),
    CityModel(city: "Aba", lat: "5.1167", lon: "7.3667"),
    CityModel(city: "Onitsha", lat: "6.1667", lon: "6.7833"),
    CityModel(city: "Maiduguri", lat: "11.8333", lon: "13.1500"),
    CityModel(city: "Benin City", lat: "6.3333", lon: "5.6222"),
    CityModel(city: "Owerri", lat: "5.4833", lon: "7.0333"),
    CityModel(city: "Sokoto", lat: "13.0622", lon: "5.2339"),
    CityModel(city: "Ebute-Metta", lat: "6.4722", lon: "3.3806"),
    CityModel(city: "Ikotun", lat: "6.5443", lon: "3.2638"),
    CityModel(city: "Uselu", lat: "6.3843", lon: "5.6098"),
    CityModel(city: "Nnewi", lat: "6.0167", lon: "6.9167"),
  ];

  List<CityModel> get cities => _cites;

  List<CityModel> get selectedCities =>
      _cites.where((city) => city.isSelected).toList();

  //

  void toggleIselectedCity(String city) {
    final cityIndex = _cites.indexWhere((element) => element.city == city);
    _cites[cityIndex].isSelected = !_cites[cityIndex].isSelected;
    notifyListeners();
  }

  void removeCity(CityModel city) {
    _cites.remove(city);
    notifyListeners();
  }
}
