import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ocesa_scan_v2/class/storage_helper.dart';

class TakePictureScreen extends StatefulWidget {
  final List<Map<String, dynamic>> guestList;

  const TakePictureScreen({Key? key, required this.guestList})
      : super(key: key);

  @override
  _TakePictureScreenState createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Take Picture'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null ? Text('No image selected.') : Image.file(_image!),
            ElevatedButton(
              onPressed: () {
                // Aquí se puede implementar la lógica para tomar la foto y guardarla en _image
              },
              child: Text('Take Picture'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navegar de regreso a la pantalla anterior y pasar los datos del guestList
                Navigator.pop(context, widget.guestList);
              },
              child: Text('Confirmar y Regresar'),
            ),
          ],
        ),
      ),
    );
  }
}
