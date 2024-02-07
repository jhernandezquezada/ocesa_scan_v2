import 'package:flutter/material.dart';
import 'package:ocesa_scan_v2/class/AppColors.dart';
import 'qr_scan_page.dart';

class ScanBtn extends StatelessWidget {
  const ScanBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the QRScanPage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QRScanPage()),
            );
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: AppColors.primaryColor, // Text color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5.0, // Elevation of the button
            padding: const EdgeInsets.symmetric(
                horizontal: 20.0, vertical: 12.0), // Padding
          ),
          child: const Text(
            'Scan QR',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
