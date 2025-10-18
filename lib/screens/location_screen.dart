import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather_model.dart';
import 'city_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clima/widgets/weather_detail.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({required this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temperature = 0;
  String icon = '';
  String cityName = '';
  double feelsLikeTemp = 0.0;
  int humidity = 0;
  double windSpeed = 0.0;
  int pressure = 0;

  WeatherModel weatherModel = WeatherModel();

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        icon = 'ERROR';
        cityName = 'Unknown';
        feelsLikeTemp = 0.0;
        humidity = 0;
        windSpeed = 0.0;
        pressure = 0;
        return;
      }

      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      feelsLikeTemp = weatherData['main']['feels_like'].toDouble();
      humidity = weatherData['main']['humidity'];
      windSpeed = weatherData['wind']['speed'].toDouble();
      pressure = weatherData['main']['pressure'];
      var condition = weatherData['weather'][0]['id'];
      icon = weatherModel.getWeatherIcon(condition);
      cityName = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Color(0xFF90e0ef),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20),
                child: Row(
                  children: [
                    IconButton(
                      icon:
                      Icon(Icons.arrow_back, color: Colors.white, size: 30),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        cityName,
                        style: GoogleFonts.lato(
                          fontSize: 50.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 15.0,
                        spreadRadius: 2.0,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 40.0, horizontal: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              icon,
                              style: kTempTextStyle,
                            ),
                            SizedBox(width: 10),
                            Text(
                              '$temperature°C',
                              style: GoogleFonts.lato(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Expanded(
                          child: GridView.count(
                            crossAxisCount: 2,
                            children: [
                              WeatherDetail(
                                icon: Icons.thermostat,
                                value: '${feelsLikeTemp.toStringAsFixed(1)}°C',
                                label: 'Feels Like',
                              ),
                              WeatherDetail(
                                icon: Icons.water_drop,
                                value: '$humidity%',
                                label: 'Humidity',
                              ),
                              WeatherDetail(
                                icon: Icons.wind_power,
                                value: '${windSpeed.toStringAsFixed(1)} m/s',
                                label: 'Wind Speed',
                              ),
                              WeatherDetail(
                                icon: Icons.compress,
                                value: '$pressure hPa',
                                label: 'Pressure',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
