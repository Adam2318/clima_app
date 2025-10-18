import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final apiKey = dotenv.env['API_KEY'];
const openURL = 'https://api.openweathermap.org/data/2.5/weather';


const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 50.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 60.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 15.0,
  fontFamily: 'Spartan MB',
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);

var kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Color(0xFFF3F3F3),
  hintText: 'Enter City Name',
  hintStyle: TextStyle(color: Color(0xFF757575)),
  prefixIcon: Padding(
    padding: const EdgeInsets.all(12.0),
    child: SvgPicture.asset('images/Search.svg'),
  ),
  suffixIcon: Builder(
    builder: (context) => Container(
      padding: EdgeInsets.only(right: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 24.0,
            width: 1.0,
            color: Colors.grey,
          ),
          SizedBox(width: 8.0),
          Icon(
            Icons.near_me,
            color: Colors.grey,
            size: 24.0,
          ),
        ],
      ),
    ),
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide.none,
  ),
);
