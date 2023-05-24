import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/models/city_model.dart';
import 'package:weather_app/core/provider/weather_provider.dart';
import 'package:weather_app/ui/widgets/globalbottomsheet.dart';

import '../../core/contants/color.dart';
import '../../core/provider/city_provider.dart';
import '../widgets/weather_item.dart';
import 'selected_city_bottomsheet_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //initiatilization
  int temperature = 0;
  int maxTemp = 0;
  String weatherStateName = 'Loading..';
  int humidity = 0;
  int windSpeed = 0;

  var currentDate = 'Loading..';

  String location = 'Lagos'; //Our default city

  @override
  void initState() {
    super.initState();
  }

  Future<void> getMyCityweather() {
    return Provider.of<WeatherProvider>(context, listen: false)
        .getCityWeather();
  }

  @override
  Widget build(BuildContext context) {
    final selectedCites = Provider.of<CityProvider>(context).selectedCities;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Our profile image
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.asset(
                  'assets/profile.png',
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
                    Image.asset(
                      'assets/pin.png',
                      width: 20,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      location,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black12),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              location,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            ),
            Text(
              currentDate,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              width: size.width,
              height: 200,
              decoration: BoxDecoration(
                  color: primaryColor,
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
                      'assets/snow.png',
                      width: 150,
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    left: 20,
                    child: Text(
                      weatherStateName,
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
                            temperature.toString(),
                            style: TextStyle(
                              fontSize: 80,
                              fontWeight: FontWeight.bold,
                              foreground: Paint()..shader = linearGradient,
                            ),
                          ),
                        ),
                        Text(
                          'o',
                          style: TextStyle(
                            fontSize: 40,
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  WeatherItem(
                    text: 'Wind Speed',
                    value: windSpeed,
                    unit: 'km/h',
                    imageUrl: 'assets/windspeed.png',
                  ),
                  WeatherItem(
                      text: 'Humidity',
                      value: humidity,
                      unit: '',
                      imageUrl: 'assets/humidity.png'),
                  WeatherItem(
                    text: 'Wind Speed',
                    value: maxTemp,
                    unit: 'C',
                    imageUrl: 'assets/max-temp.png',
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  'Today',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                Text(
                  'Next 7 Days',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: primaryColor),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            // Expanded(
            //     child: ListView.builder(
            //         scrollDirection: Axis.horizontal,
            //         itemCount: consolidatedWeatherList.length,
            //         itemBuilder: (BuildContext context, int index) {
            //           String today = DateTime.now().toString().substring(0, 10);
            //           var selectedDay =
            //               consolidatedWeatherList[index]['applicable_date'];
            //           var futureWeatherName =
            //               consolidatedWeatherList[index]['weather_state_name'];
            //           var weatherUrl =
            //               futureWeatherName.replaceAll(' ', '').toLowerCase();

            //           var parsedDate = DateTime.parse(
            //               consolidatedWeatherList[index]['applicable_date']);
            //           var newDate = DateFormat('EEEE')
            //               .format(parsedDate)
            //               .substring(0, 3); //formateed date

            //           return GestureDetector(
            //             onTap: () {
            //               Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(consolidatedWeatherList: consolidatedWeatherList, selectedId: index, location: location,)));
            //             },
            //             child: Container(
            //               padding: const EdgeInsets.symmetric(vertical: 20),
            //               margin: const EdgeInsets.only(
            //                   right: 20, bottom: 10, top: 10),
            //               width: 80,
            //               decoration: BoxDecoration(
            //                   color: selectedDay == today
            //                       ? primaryColor
            //                       : Colors.white,
            //                   borderRadius:
            //                       const BorderRadius.all(Radius.circular(10)),
            //                   boxShadow: [
            //                     BoxShadow(
            //                       offset: const Offset(0, 1),
            //                       blurRadius: 5,
            //                       color: selectedDay == today
            //                           ? primaryColor
            //                           : Colors.black54.withOpacity(.2),
            //                     ),
            //                   ]),
            //               child: Column(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 children: [
            //                   Text(
            //                     "${consolidatedWeatherList[index]['the_temp']
            //                             .round()}C",
            //                     style: TextStyle(
            //                       fontSize: 17,
            //                       color: selectedDay == today
            //                           ? Colors.white
            //                           : primaryColor,
            //                       fontWeight: FontWeight.w500,
            //                     ),
            //                   ),
            //                   Image.asset(
            //                     'assets/' + weatherUrl + '.png',
            //                     width: 30,
            //                   ),
            //                   Text(
            //                     newDate,
            //                     style: TextStyle(
            //                       fontSize: 17,
            //                       color: selectedDay == today
            //                           ? Colors.white
            //                           : primaryColor,
            //                       fontWeight: FontWeight.w500,
            //                     ),
            //                   )
            //                 ],
            //               ),
            //             ),
            //           );
            //         }))
          ],
        ),
      ),
    );
  }
}
