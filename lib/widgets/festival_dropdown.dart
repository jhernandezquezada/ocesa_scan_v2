import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ocesa_scan_v2/class/festival.dart';
import 'package:ocesa_scan_v2/class/storage_helper.dart';
import 'package:ocesa_scan_v2/screens/manual_search_page.dart';
import 'package:ocesa_scan_v2/screens/qr_scan_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ocesa_scan_v2/screens/navi.dart';
//import 'festival_details.dart';  // Importa la nueva ventana

class FestivalDropdown extends StatefulWidget {
  @override
  _FestivalDropdownState createState() => _FestivalDropdownState();
}

class _FestivalDropdownState extends State<FestivalDropdown> {
  late Future<List<Festival>> festivals;

  @override
  void initState() {
    super.initState();
    festivals = fetchFestivals();
  }

  Future<List<Festival>> fetchFestivals() async {
    final response = await http
        .get(Uri.parse('https://guestlist.ocesa.mx/api/api-festival.php'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((e) => Festival.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load festivals');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Festival>>(
      future: festivals,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Festival> festivals = snapshot.data!;

          return DropdownButton<Festival>(
            hint: Text('Select a festival'),
            items: festivals
                .map((festival) => DropdownMenuItem<Festival>(
                      value: festival,
                      child: Text(festival.name),
                    ))
                .toList(),
            onChanged: (Festival? selectedFestival) async {
              if (selectedFestival != null) {
                int festivalId = selectedFestival.id;
                await StorageHelper.saveFestivalId(festivalId);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Navi(),
                  ),
                );
              }
            },
          );
        }
      },
    );
  }
}
