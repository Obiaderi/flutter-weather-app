import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/provider/city_provider.dart';
import 'home_screen.dart';

class SelectedCityScreen extends StatelessWidget {
  const SelectedCityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedCites = Provider.of<CityProvider>(context).selectedCities;
    return ListView.builder(
        itemCount: selectedCites.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.only(left: 10, top: 20, right: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 80,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  )
                ]),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    // Navigator.of(context).pushNamed(
                    //   WeatherDetailsScreen.routeName,
                    //   arguments: selectedCites[index],
                    // );
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/clear.png",
                        width: 40,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        selectedCites[index].city,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Provider.of<CityProvider>(context, listen: false)
                        .removeCity(selectedCites[index]);
                  },
                  child: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                )
              ],
            ),
          );
        });
  }
}
