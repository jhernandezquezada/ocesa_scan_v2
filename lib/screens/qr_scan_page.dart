import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'take_qr_and_picture.dart';

class QRScanPage extends StatefulWidget {
  const QRScanPage({super.key});

  @override
  _QRScanPageState createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  bool isScanning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Scan'),
      ),
      body: Stack(
        children: [
          // Camera preview takes the entire screen
          Positioned.fill(
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.red,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
              ),
              onPermissionSet: (ctrl, p) => _onPermissionSet(ctrl, p),
            ),
          ),
          // Start Scanning and Quit Buttons at the bottom
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Start scanning when the button is pressed
                    startScanning();
                  },
                  child: const Text('Start Scanning'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Stop scanning and exit the screen
                    Navigator.pop(context);
                  },
                  child: const Text('Quit'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    controller.scannedDataStream.listen((Barcode scanData) {
      String? qrContent = scanData.code;
      String extractedNumbers = extractNumbers(qrContent ?? '');

      // Dispose of QRScanPage and navigate to TakeQrAndPicture
      Navigator.pop(context);

      // Navigate to another screen with the extracted numbers
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TakeQrAndPicture(extractedNumbers),
        ),
      );
    });
  }

  void _onPermissionSet(QRViewController ctrl, bool p) {
    if (!p) {
      // Handle camera permission denied
    }
  }

  void startScanning() {
    setState(() {
      isScanning = true;
    });

    controller.resumeCamera();
  }

  String extractNumbers(String qrText) {
    RegExp regex = RegExp(r'\d+');
    Iterable<Match> matches = regex.allMatches(qrText);
    return matches.map((match) => match.group(0)!).join();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
