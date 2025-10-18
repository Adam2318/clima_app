import 'package:clima/services/location_service.dart';
import 'package:clima/services/networking_service.dart';
import 'package:clima/utilities/constants.dart';
import 'package:geolocator/geolocator.dart';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    var url = '$openURL?q=$cityName&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }


  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    Position? position;
    bool gotPosition = false;

    while (!gotPosition) {
      try {
        position = await location.getCurrentPossition();
        gotPosition = true;
      } catch (e) {
        if (e.toString().contains('disabled')) {
          await Future.delayed(Duration(seconds: 1));
        } else {
          rethrow;
        }
      }
    }

    NetworkHelper networkHelper = NetworkHelper(
        '$openURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }
}
