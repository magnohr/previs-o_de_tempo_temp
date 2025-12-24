import 'DayWeatherModel.dart';
import 'HourWeatherModel.dart';

class WeatherModel {
  final String city;
  final int temperature;
  final String description;
  final int maxTemp;
  final int minTemp;

  final String houseImage;
   List<HourWeatherModel> hours;
   List<DayWeatherModel> days;

  WeatherModel({
    required this.city,
    required this.temperature,
    required this.description,
    required this.maxTemp,
    required this.minTemp,

    required this.houseImage,
    required this.hours,
    required this.days,
  });

  // 🔥 JSON DA API (OpenWeather)
  factory WeatherModel.fromApiJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json['name'],
      temperature: json['main']['temp'].round(),
      description: json['weather'][0]['description'],
      maxTemp: json['main']['temp_max'].round(),
      minTemp: json['main']['temp_min'].round(),


      houseImage: 'assets/images/house.png',
      hours: [],
      days: [],
    );
  }
}
