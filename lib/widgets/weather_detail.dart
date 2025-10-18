import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherDetail extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  WeatherDetail({required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      color: Colors.blueGrey[50],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.blueGrey,
            size: 30.0,
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.lato(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}
