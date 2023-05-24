class CityModel {
  String city;
  String? lat;
  String lon;
  bool isSelected;

  CityModel({
    required this.city,
    required this.lat,
    required this.lon,
    this.isSelected = false,
  });
}
