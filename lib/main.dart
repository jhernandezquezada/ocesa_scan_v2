import 'package:flutter/material.dart';
import 'package:ocesa_scan_v2/widgets/festival_dropdown.dart';
import 'package:ocesa_scan_v2/widgets/festival_with_image.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
      home: Scaffold(
        appBar: AppBar(
          title: Text('OCESA SCAN'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: FestivalWithImage(
                const SizedBox(height: 15),
                child: FestivalDropdown(),
                imageUrl: 'assets/img/music-l.png',
                imageUrl2: 'assets/img/ocesa-logo-white.png',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
