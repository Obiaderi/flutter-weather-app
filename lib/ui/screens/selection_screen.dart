import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/models/city_model.dart';
import 'package:weather_app/core/provider/city_provider.dart';

import '../../core/contants/color.dart';

class CitySelectionScreen extends StatefulWidget {
  const CitySelectionScreen({super.key});

  @override
  State<CitySelectionScreen> createState() => _CitySelectionScreenState();
}

class _CitySelectionScreenState extends State<CitySelectionScreen> {
  @override
  Widget build(BuildContext context) {
    final citiesProvider = Provider.of<CityProvider>(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: AppColor.brandBlue,
          titleSpacing: 0,
          elevation: 0.0,
          title: const Text(
            'Select City',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: citiesProvider.cities.length,
                itemBuilder: (BuildContext context, int index) {
                  CityModel city = citiesProvider.cities[index];
                  city.isSelected = citiesProvider.selectedCities.indexWhere(
                          (it) => it.city.trim() == city.city.trim()) >
                      -1;

                  return Container(
                    margin: const EdgeInsets.only(left: 10, top: 20, right: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: size.height * .08,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: AppColor.white,
                        border: city.isSelected == true
                            ? Border.all(
                                color: AppColor.brandOrange.withOpacity(.6),
                                width: 2,
                              )
                            : Border.all(color: Colors.white),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withOpacity(.2),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          )
                        ]),
                    child: InkWell(
                      onTap: () {
                        citiesProvider.toggleIselectedCity(city: city);
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            city.isSelected
                                ? 'assets/images/checked.png'
                                : 'assets/images/unchecked.png',
                            width: 30,
                            color: AppColor.brandOrange,
                          ),
                          const SizedBox(
                            width: 24,
                          ),
                          Text(
                            citiesProvider.cities[index].city,
                            style: TextStyle(
                                fontSize: 16,
                                color: city.isSelected
                                    ? primaryColor
                                    : Colors.black54,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.check),
        ));
  }
}
