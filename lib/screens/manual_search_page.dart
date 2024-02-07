import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ocesa_scan_v2/class/storage_helper.dart';
import 'package:ocesa_scan_v2/screens/user_details_page.dart';

class ManualSearchPage extends StatefulWidget {
  const ManualSearchPage({super.key});

  @override
  _ManualSearchPageState createState() => _ManualSearchPageState();
}

class _ManualSearchPageState extends State<ManualSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> searchResults = [];
  String? festivalName;

  @override
  void initState() {
    super.initState();
    _fetchFestivalName();
  }

  Future<void> _fetchFestivalName() async {
    festivalName = await StorageHelper.getFestivalName();
    print(festivalName);
    setState(() {}); // Trigger a rebuild after fetching festivalName
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manual Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Enter search term',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _performSearch();
              },
              child: const Text('Search'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _buildSearchResults(),
            ),
            const SizedBox(height: 16),
            Text(
              'Working on: ${festivalName ?? "Loading..."}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    if (searchResults.isEmpty) {
      return const Center(
        child: Text('No results found.'),
      );
    }

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final record = searchResults[index];
        final fullName = '${record['fullname']}';

        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          color: Colors.white,
          child: ListTile(
            title: Text(fullName, style: const TextStyle(color: Colors.black)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(record['email'],
                    style: const TextStyle(color: Colors.purpleAccent)),
                const SizedBox(height: 4), // Add some space between the subtitles
                Text(
                  record['idStatus'], // Add your additional subtitle here
                  style: const TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            onTap: () {
              _navigateToUserDetailsPage(record);
            },
            contentPadding: const EdgeInsets.all(16), // Adjust padding as needed
          ),
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
      print('Error: ${response.statusCode}');
    }
  }

  void _navigateToUserDetailsPage(dynamic record) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserDetailsPage(
          id: record['id'],
          name: record['fullname'],
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
