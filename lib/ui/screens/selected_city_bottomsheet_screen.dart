import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/contants/color.dart';
import 'package:weather_app/core/provider/weather_provider.dart';
import 'package:weather_app/ui/utils/media_query.dart';
import '../../core/provider/city_provider.dart';

class SelectedCityBottomsheetScreen extends StatefulWidget {
  const SelectedCityBottomsheetScreen({super.key});

  static const routeName = '/bottom-sheet';

  @override
  State<SelectedCityBottomsheetScreen> createState() =>
      _SelectedCityBottomsheetScreenState();
}

class _SelectedCityBottomsheetScreenState
    extends State<SelectedCityBottomsheetScreen> {
  bool isSelectedCity = false;

  @override
  Widget build(BuildContext context) {
    //final cityProvider = Provider.of<CityProvider>(context);

    return Consumer<CityProvider>(builder: (context, cityProvider, _) {
      return Container(
        height: deviceHeight(context) * .8,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  const Text(
                    'Your Selected Cities',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/city-selection');
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: const BoxDecoration(
                        color: AppColor.brandOrange,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40.0),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(0),
                  itemCount: cityProvider.selectedCities.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        cityProvider.setSelectedCity(
                            cityProvider.selectedCities[index]);
                        Provider.of<WeatherProvider>(context, listen: false)
                            .getCityWeather(
                                long: cityProvider.selectedCity!.lon,
                                lat: cityProvider.selectedCity!.lat);
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 24),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: cityProvider.selectedCity ==
                                  cityProvider.selectedCities[index]
                              ? AppColor.brandBlue
                              : AppColor.brownGrey,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Row(
                          children: [
                            // Image.asset(
                            //   "assets/clear.png",
                            //   width: 40,
                            // ),
                            // const SizedBox(
                            //   width: 20,
                            // ),
                            Text(
                              cityProvider.selectedCities[index].city,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: cityProvider.selectedCity ==
                                        cityProvider.selectedCities[index]
                                    ? AppColor.white
                                    : AppColor.brandBlack,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    height: 10,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
