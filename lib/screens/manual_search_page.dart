// manual_search_page.dart

import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ocesa_scan_v2/class/storage_helper.dart';
import 'package:ocesa_scan_v2/screens/user_details_page.dart';
import 'package:ocesa_scan_v2/class/shared_preferences_helper.dart';
import 'package:ocesa_scan_v2/widgets/festival_model.dart';

class ManualSearchPage extends StatefulWidget {
  // ManualSearchPage();

  @override
  _ManualSearchPageState createState() => _ManualSearchPageState();
}

class _ManualSearchPageState extends State<ManualSearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manual Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Enter search term',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _performSearch();
              },
              child: Text('Search'),
            ),
            SizedBox(height: 16),
            Expanded(
              child: _buildSearchResults(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    if (searchResults.isEmpty) {
      return Center(
        child: Text('No results found.'),
      );
    }

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final record = searchResults[index];
        final fullName = '${record['fullname']}';

        return ListTile(
          title: Text(fullName),
          subtitle: Text(record['email']),
          onTap: () {
            _navigateToUserDetailsPage(record);
          },
        );
      },
    );
  }

  Future<void> _performSearch() async {
    int? festivalId = await StorageHelper.getFestivalId();
    final searchTerm = _searchController.text;

    if (searchTerm.isEmpty) {
      return;
    }

    final response = await http.get(
      Uri.parse(
          'https://guestlist.ocesa.mx/api/api-gl-fest.php?f=$festivalId&s=$searchTerm'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);

      setState(() {
        searchResults = jsonData;
      });
    } else {
      // Handle error cases
      print('Error: ${response.statusCode}');
    }
  }

  void _navigateToUserDetailsPage(dynamic record) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserDetailsPage(
          name: record['name'],
          lastName: record['lastName'],
          email: record['email'],
          qty: record['quantity'],
          access: record['idAccess'],
          days: record['idDays'],
          idStatus: record['idStatus'],
          identification: record['identification'],
        ),
      ),
    );
  }
}
