import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'core/provider/city_provider.dart';
import 'core/provider/weather_provider.dart';

final allProviders = <SingleChildWidget>[
  ChangeNotifierProvider(create: (_) => CityProvider()),
  ChangeNotifierProvider(create: (_) => WeatherProvider()),
];
