import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ocesa_scan_v2/class/AppColors.dart';
import 'package:ocesa_scan_v2/class/storage_helper.dart';
import 'package:ocesa_scan_v2/screens/scan_btn.dart';

String? idStatus;
String? fullname;
String? email;
String? quantity;
String? idAccess;
String? idDays;
String id = "";

class TakeQrAndPicture extends StatefulWidget {
  final String extractedNumber;

  const TakeQrAndPicture(this.extractedNumber, {super.key});

  @override
  _TakeQrAndPictureState createState() => _TakeQrAndPictureState();
}

class _TakeQrAndPictureState extends State<TakeQrAndPicture> {
  List<Map<String, dynamic>> guestList = [];
  late File? _image;

  @override
  void initState() {
    super.initState();
    _image = null; // Inicializar _image como nulo
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      int? festivalId = await StorageHelper.getFestivalId();
      String apiUrl =
          'https://guestlist.ocesa.mx/api/api-guest-valid.php?f=$festivalId&s=${widget.extractedNumber}';
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        if (jsonData.isNotEmpty) {
          for (var guestData in jsonData) {
            id = guestData['id'];
            idStatus = guestData['idStatus'];
            fullname = guestData['fullname'];
            email = guestData['email'];
            quantity = guestData['quantity'];
            idAccess = guestData['idAccess'];
            idDays = guestData['idDays'];
            if (idStatus == "DELIVERED" || idStatus == "SAVED") {
              showAwesomeDialog(idStatus);
            } else {}
          }
        } else {
          showEmpty();
        }
        setState(() {
          guestList =
              jsonData.map((data) => Map<String, dynamic>.from(data)).toList();
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void showEmpty() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.scale,
      title: 'INVALID QR',
      desc: 'No results, wrong Festival',
      btnOkText: 'Okay',
      btnOkOnPress: () {
        Navigator.pop(context);
      },
    ).show();
  }

  void showAwesomeDialog(status) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.scale,
      title: 'INVALID QR',
      desc: 'TICKETS STATUS: $status',
      btnOkText: 'Okay',
      btnOkOnPress: () {
        Navigator.pop(context);
      },
    ).show();
  }

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _sendDataToApi() async (File imageFile, List<Map<String, dynamic>> guestList) async {
    try {
      // URL de la API
      String apiUrl = 'https://tu-api.com/subir-datos-y-foto';

      // Crea la solicitud multipart
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

      // Agrega la imagen a la solicitud
      request.files
          .add(await http.MultipartFile.fromPath('image', imageFile.path));

      // Agrega los datos de guestList como campos de texto en la solicitud
      for (var guestData in guestList) {
        request.fields['fullname'] = guestData['fullname'];
        request.fields['email'] = guestData['email'];
        request.fields['quantity'] = guestData['quantity'];
        request.fields['idAccess'] = guestData['idAccess'];
        request.fields['idDays'] = guestData['idDays'];
      }

      // Realiza la solicitud
      var response = await request.send();

      // Verifica si la solicitud fue exitosa
      if (response.statusCode == 200) {
        // La solicitud fue exitosa
        print('Datos y foto enviados correctamente a la API.');
      } else {
        // Hubo un error en la solicitud
        print(
            'Error al enviar datos y foto a la API. Código de estado: ${response.statusCode}');
      }
    } catch (error) {
      // Maneja cualquier error que ocurra durante el proceso
      print('Error al enviar datos y foto a la API: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take QR and Picture'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                fullname!,
                style: const TextStyle(
                  color: AppColors.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                email!,
                style: const TextStyle(
                  color: AppColors.textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$idAccess $idDays',
                style: const TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _image != null
                  ? Container(
                      height: 200, // Alto deseado para la imagen
                      child: Image.file(
                          _image!), // Muestra la foto tomada si existe
                    )
                  : Container(),
              ElevatedButton(
                onPressed: _takePicture,
                child: Text('Take Picture'),
              ),
              ElevatedButton(
                onPressed: _sendDataToApi,
                child: Text('Send Data to API'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
