import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'location_screen.dart';
import 'package:clima/services/weather_model.dart';
import 'dart:ui';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName = '';
  WeatherModel weatherModel = WeatherModel();
  bool isLoading = false;
  final FocusNode _focusNode = FocusNode();

  Future<void> _getWeatherAndNavigate(Function getWeather) async {
    FocusScope.of(context).unfocus();

    setState(() {
      isLoading = true;
    });

    var weatherData = await getWeather();

    setState(() {
      isLoading = false;
    });

    if (weatherData == null) {
      // Show an error dialog if weather data is null
      _showErrorDialog('Could not fetch weather data for $cityName.');
      return;
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(locationWeather: weatherData);
    }));
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error', style: GoogleFonts.lato()),
          content: Text(message, style: GoogleFonts.lato()),
          actions: [
            TextButton(
              child: Text('OK', style: GoogleFonts.lato()),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Color(0xFF90e0ef),
        resizeToAvoidBottomInset:
        false, // Prevents shifting on keyboard display
        body: Stack(
          children: [
            SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Clima',
                          style: GoogleFonts.pacifico(
                            fontSize: 40,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),
                        Image.asset(
                          'images/icon.png',
                          width: 150,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 50),
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
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 50),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: 40, left: 20, right: 20),
                                      decoration: BoxDecoration(boxShadow: [
                                        BoxShadow(
                                            color: Color(0xff1D1617)
                                                .withOpacity(0.11),
                                            blurRadius: 40,
                                            spreadRadius: 0.0),
                                      ]),
                                      child: TextField(
                                        focusNode: _focusNode,
                                        style: TextStyle(color: Colors.black),
                                        cursorColor: Colors.grey,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Color(0xFFF3F3F3),
                                          hintText: 'Enter City Name',
                                          hintStyle: TextStyle(
                                              color: Colors.grey[400]),
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: SvgPicture.asset(
                                                'images/Search.svg'),
                                          ),
                                          suffixIcon: Builder(
                                            builder: (context) => Container(
                                              padding:
                                              EdgeInsets.only(right: 8.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    height:
                                                    24.0,
                                                    width:
                                                    1.0,
                                                    color: Colors.grey,
                                                  ),
                                                  SizedBox(
                                                      width:
                                                      8.0),
                                                  GestureDetector(
                                                    onTap: () =>
                                                        _getWeatherAndNavigate(
                                                            weatherModel
                                                                .getLocationWeather),
                                                    child: Icon(
                                                      Icons.near_me,
                                                      color: Colors.grey,
                                                      size: 24.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                        onChanged: (value) {
                                          cityName = value;
                                        },
                                      ),
                                    ),
                                  ),
                                  /*TextButton(
                                    onPressed: () => _getWeatherAndNavigate(
                                        weatherModel.getLocationWeather),
                                    child: Icon(
                                      Icons.near_me,
                                      color: Colors.grey,
                                      size: 50.0,
                                    ),
                                  ),*/
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Color(0xFF90e0ef),
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                elevation: 5,
                              ),
                              onPressed: () => _getWeatherAndNavigate(
                                      () => weatherModel.getCityWeather(cityName)),
                              child: Text(
                                'Get Weather',
                                style: GoogleFonts.lato(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
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
            if (isLoading) ...[
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              Center(
                child: SpinKitDoubleBounce(
                  color: Colors.white,
                  size: 100,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
