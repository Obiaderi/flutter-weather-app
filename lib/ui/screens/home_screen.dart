import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/enum/view_state.dart';
import 'package:weather_app/core/models/city_model.dart';
import 'package:weather_app/core/provider/weather_provider.dart';
import 'package:weather_app/core/utils.dart';
import 'package:weather_app/ui/utils/media_query.dart';
import 'package:weather_app/ui/widgets/globalbottomsheet.dart';
import 'package:weather_app/ui/widgets/weather_info_widget.dart';

import '../../core/contants/color.dart';
import '../../core/contants/images.dart';
import '../../core/provider/city_provider.dart';
import '../../core/services/geo_locator_service.dart';
import 'selected_city_bottomsheet_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //initiatilization

  late CityProvider cityProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeCity();
    });
  }

  _getMyCityweather(CityModel city) {
    return Provider.of<WeatherProvider>(context, listen: false)
        .getCityWeather(lat: city.lat, long: city.lon);
  }

  _initializeCity() {
    cityProvider = Provider.of<CityProvider>(context, listen: false);
    cityProvider.setSelectedCity(cityProvider.cities.first);
    _getMyCityweather(cityProvider.selectedCity!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          titleSpacing: 0,
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: deviceHeight(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Our profile image
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Image.asset(
                    avatar,
                    width: 40,
                    height: 40,
                  ),
                ),
                //our location dropdown
                GestureDetector(
                  onTap: () {
                    GlobalBottomSheet.customShowModelBottomSheet(
                      context: context,
                      widget: const SelectedCityBottomsheetScreen(),
                    );
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Image.asset(
                      //   'assets/pin.png',
                      //   width: 20,
                      // ),
                      // const SizedBox(
                      //   width: 4,
                      // ),
                      Consumer<CityProvider>(builder: (context, vm, _) {
                        return Text(
                          vm.selectedCity?.city ?? "",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: AppColor.brandBlack),
                        );
                      }),
                      const SizedBox(width: 4),
                      const Icon(
                        Iconsax.arrow_down_1,
                        color: AppColor.brandOrange,
                        //size: 30,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        body: _mainContent(),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              //get my current location lat/long
              _getCurrentLocation();
            },
            backgroundColor: AppColor.brandBlue,
            label: const Text("Current Location"),
            icon: const Icon(Iconsax.location)));
  }

  _mainContent() {
    return Consumer<WeatherProvider>(builder: (context, vm, _) {
      if (vm.getWeatherViewState == ViewState.busy) {
        return SizedBox(
          width: deviceWidth(context),
          height: deviceHeight(context),
          child: Center(
            child: LottieBuilder.asset(lottiew2),
          ),
        );
      }
      if (vm.getWeatherViewState == ViewState.error) {
        return SizedBox(
          width: deviceWidth(context),
          height: deviceHeight(context),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Unable to fetch weather information\nat this time.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColor.brandBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 24),
                  TextButton(
                    onPressed: () {
                      _getMyCityweather(cityProvider.selectedCity!);
                    },
                    child: const Text(
                      "Try Again",
                      style: TextStyle(
                          color: AppColor.brandOrange,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
      if (vm.getWeatherViewState == ViewState.completed &&
          vm.weatherModel != null) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    vm.weatherModel!.name ?? "",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                  ),
                  Text(
                    AppUtils.dayWithSuffixMonthAndYear(DateTime.now()),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColor.brandBlack.withOpacity(0.4),
                      fontSize: 16.0,
                    ),
                  )
                ],
              ),
              Text(
                vm.weatherModel?.weather?.first.main ?? "",
                style: const TextStyle(
                  color: AppColor.brandBlack,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                width: deviceWidth(context),
                height: 200,
                decoration: BoxDecoration(
                    color: AppColor.brandBlue,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(.5),
                        offset: const Offset(0, 25),
                        blurRadius: 10,
                        spreadRadius: -12,
                      )
                    ]),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: -40,
                      left: 20,
                      child: Image.asset(
                        snow,
                        width: 150,
                      ),
                    ),
                    // Positioned(
                    //   top: -100,
                    //   left: -40,
                    //   child: Lottie.asset("assets/images/lottie/w2.json", width: 250),
                    // ),
                    Positioned(
                      bottom: 30,
                      left: 20,
                      child: Text(
                        vm.weatherModel?.weather?.first.description ?? "",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      right: 20,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              vm.weatherModel?.main?.temp?.toString() ?? "",
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                foreground: Paint()..shader = linearGradient,
                              ),
                            ),
                          ),
                          Text(
                            'o',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              foreground: Paint()..shader = linearGradient,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Main",
                      style: TextStyle(
                          fontSize: 24,
                          color: AppColor.brandBlue,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Container(
                    height: 220,
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        WeatherItemWidget(
                          value:
                              vm.weatherModel?.main?.humidity.toString() ?? "",
                          label: "Humity",
                          imageUrl: humidityImg,
                        ),
                        const SizedBox(width: 16),
                        WeatherItemWidget(
                          value:
                              vm.weatherModel?.main?.pressure.toString() ?? "",
                          label: "Pressure",
                          imageUrl: sleetImg,
                          c1: AppColor.brandOrange,
                        ),
                        const SizedBox(width: 16),
                        vm.weatherModel?.main?.seaLevel != null
                            ? WeatherItemWidget(
                                value: vm.weatherModel?.main?.seaLevel
                                        .toString() ??
                                    "",
                                label: "Sea Level",
                                imageUrl: humidityImg,
                                c1: AppColor.brandBlack)
                            : const SizedBox(),
                        const SizedBox(width: 16),
                        vm.weatherModel?.main?.grndLevel != null
                            ? WeatherItemWidget(
                                value: vm.weatherModel?.main?.grndLevel
                                        .toString() ??
                                    "",
                                label: "Ground Level",
                                imageUrl: sleetImg,
                                c1: AppColor.red,
                              )
                            : const SizedBox(),
                        // WeatherItem(
                        //   text: 'Wind Speed',
                        //   value: maxTemp,
                        //   unit: 'C',
                        //   imageUrl: 'assets/images/max-temp.png',
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              //Wind
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Wind",
                      style: TextStyle(
                          fontSize: 24,
                          color: AppColor.brandBlue,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Container(
                    height: 220,
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        WeatherItemWidget(
                          value: vm.weatherModel?.wind?.speed.toString() ?? "",
                          label: "Speed",
                          imageUrl: 'assets/images/windspeed.png',
                          c1: Colors.green,
                        ),
                        const SizedBox(width: 16),
                        WeatherItemWidget(
                          value: vm.weatherModel?.wind?.deg.toString() ?? "",
                          label: "Deg",
                          imageUrl: 'assets/images/windspeed.png',
                          c1: Colors.pink,
                        ),
                        const SizedBox(width: 16),
                        vm.weatherModel?.wind?.gust != null
                            ? WeatherItemWidget(
                                value: vm.weatherModel?.wind?.gust.toString() ??
                                    "",
                                label: "Sea Level",
                                imageUrl: 'assets/images/humidity.png',
                                c1: Colors.purple,
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }

      return const SizedBox();
    });
  }

  _getCurrentLocation() async {
    try {
      final weatherProvider =
          Provider.of<WeatherProvider>(context, listen: false);
      final cityProvider = Provider.of<CityProvider>(context, listen: false);
      weatherProvider.setWeatherViewState(ViewState.busy);
      final res = await GeoLocatorService().getCurrentLocation();

      //Error getting user current lat/long
      if (res.first != 200) {
        weatherProvider.setWeatherViewState(ViewState.error);
        _showErrorBs(res.last.toString());
        return;
      }

      String long = res.last.longitude.toString();
      String lat = res.last.latitude.toString();
      cityProvider.setSelectedCity(CityModel(
          city: "Current Location", lat: lat, lon: long, isSelected: false));
      weatherProvider.getCityWeather(long: long, lat: lat);
    } catch (_) {
      _showErrorBs("Something went wrong. Please try again.");
    }
  }

  _showErrorBs(String msg) {
    GlobalBottomSheet.customShowModelBottomSheet(
        context: context,
        widget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 60),
            Text(
              msg,
              style: const TextStyle(
                  color: AppColor.brandBlack,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 60),
          ],
        ));
  }
}
