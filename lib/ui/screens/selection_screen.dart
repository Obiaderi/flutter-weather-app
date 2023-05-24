import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/provider/city_provider.dart';

import '../../core/contants/color.dart';

class CitySelctionScreen extends StatefulWidget {
  const CitySelctionScreen({super.key});

  static const String routeName = '/city-selection';

  @override
  State<CitySelctionScreen> createState() => _CitySelctionScreenState();
}

class _CitySelctionScreenState extends State<CitySelctionScreen> {
  @override
  Widget build(BuildContext context) {
    final cities = Provider.of<CityProvider>(context, listen: false).cities;
    Size size = MediaQuery.of(context).size;

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: cities.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: const EdgeInsets.only(left: 10, top: 20, right: 10),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: size.height * .08,
          width: size.width,
          decoration: BoxDecoration(
              border: cities[index].isSelected == true
                  ? Border.all(
                      color: secondaryColor.withOpacity(.6),
                      width: 2,
                    )
                  : Border.all(color: Colors.white),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                )
              ]),
          child: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    setState(() {
                      cities[index].isSelected = !cities[index].isSelected;
                    });
                  },
                  child: Image.asset(
                    cities[index].isSelected == true
                        ? 'assets/checked.png'
                        : 'assets/unchecked.png',
                    width: 30,
                  )),
              const SizedBox(
                width: 10,
              ),
              Text(
                cities[index].city,
                style: TextStyle(
                  fontSize: 16,
                  color: cities[index].isSelected == true
                      ? primaryColor
                      : Colors.black54,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
