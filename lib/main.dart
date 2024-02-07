import 'package:flutter/material.dart';
import 'package:ocesa_scan_v2/class/AppColors.dart';
import 'package:ocesa_scan_v2/widgets/festival_dropdown.dart';
import 'package:ocesa_scan_v2/widgets/festival_with_image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.backgroundColor,
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColors.backgroundColor,
      ),
      themeMode: ThemeMode.light,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('OCESA SCAN.'),
          backgroundColor: AppColors.backgroundColor,
        ),
        body: const Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: FestivalWithImage(
                SizedBox(height: 15),
                imageUrl: 'assets/img/music-l.png',
                imageUrl2: 'assets/img/ocesa-logo-orange.png',
                child: FestivalDropdown(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
