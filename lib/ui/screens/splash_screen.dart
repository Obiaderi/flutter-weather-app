import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/contants/storage_key.dart';
import 'package:weather_app/core/routes/routes.dart';
import 'package:weather_app/core/services/storage_service.dart';
import '../../core/contants/color.dart';
import '../../core/contants/images.dart';
import '../../core/models/city_model.dart';
import '../../core/provider/city_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initCities();
  }

  initCities() async {
    final cities =
        await StorageService.getStringItem(StorageKey.selectedCities);
    if (cities != null) {
      _updateCities(cities);
    }
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, RoutePath.home);
    });
  }

  _updateCities(String cities) {
    Provider.of<CityProvider>(context, listen: false)
        .setSelectedCities(cityModelFromJson(cities));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.brandBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset(lottiew1),
            const SizedBox(height: 24.0),
            const Text(
              'EDOBOR',
              style: TextStyle(
                  fontSize: 32.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Weather App',
              style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.white.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                  letterSpacing: 4),
            ),
          ],
        ),
      ),
    );
  }
}
