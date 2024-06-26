// bottom_navigation_bar.dart

import 'package:flutter/material.dart';
import 'package:ocesa_scan_v2/screens/delivered_page.dart';
import 'package:ocesa_scan_v2/screens/scan_btn.dart';
import '../screens/manual_search_page.dart';
import 'package:ocesa_scan_v2/main.dart';
import 'package:ocesa_scan_v2/class/AppColors.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  _BottomNavigationBarWidgetState createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    ScanBtn(),
    ManualSearchPage(),
    DeliveredPage(),
    MyApp(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 3) {
      // Navigate to MyApp when 'Select Festival' tab is tapped
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 35,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.accentColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'QR Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Manual Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Delivered',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Select Festival',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          _onItemTapped(index);
        },
      ),
    );
  }
}
