import 'package:flutter/material.dart';
import 'package:ocesa_scan_v2/widgets/bottom_navigation_bar.dart';

class Navi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF301865),
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF301865),
      ),
      themeMode: ThemeMode.dark,
      home: BottomNavigationBarWidget(),
    );
  }
}
