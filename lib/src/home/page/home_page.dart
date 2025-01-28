import 'package:bookreview/src/common/components/app_font.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AppFont('Home'),
      ),
    );
  }
}
