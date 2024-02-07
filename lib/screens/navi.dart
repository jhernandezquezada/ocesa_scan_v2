import 'package:flutter/material.dart';
import 'package:ocesa_scan_v2/widgets/bottom_navigation_bar.dart';

class Navi extends StatelessWidget {
  const Navi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 245, 245, 245),
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 245, 245, 245),
      ),
      themeMode: ThemeMode.light,
      home: BottomNavigationBarWidget(),
    );
  }
}
