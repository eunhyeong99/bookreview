import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFont extends StatelessWidget {
  final String text;
  final double? size;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;

  const AppFont(
    this.text, {
    super.key,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.left,
    this.size = 15,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.notoSans(
        fontSize: size,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
