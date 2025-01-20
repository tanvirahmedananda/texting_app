import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PoppinsText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight weight;

  const PoppinsText({
    super.key,
    required this.text,
    required this.fontSize,
    required this.color,
    required this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
          textStyle:
              TextStyle(fontSize: fontSize, color: color, fontWeight: weight)),
    );
  }
}
