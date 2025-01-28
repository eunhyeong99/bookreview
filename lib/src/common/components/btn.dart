import 'package:bookreview/src/common/components/app_font.dart';
import 'package:flutter/material.dart';

class Btn extends StatelessWidget {
  final Function() onTap;
  final String text;
  final Color? backgroundColor;

  const Btn({
    super.key,
    required this.onTap,
    required this.text,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: backgroundColor ?? Color(0xffF4AA2B),
        ),
        child: AppFont(
          text,
          fontWeight: FontWeight.bold,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
