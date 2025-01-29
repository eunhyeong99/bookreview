import 'package:flutter/material.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          Divider(color: Color(0xff000000),height: 1),
          Divider(color: Color(0xff323232),height: 1),
        ],
      ),
    );
  }
}
