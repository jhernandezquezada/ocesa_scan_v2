// user_details_page.dart

import 'package:flutter/material.dart';

class UserDetailsPage extends StatelessWidget {
  final int id;
  final String name;
  final String email;
  final String idStatus;
  final String access;
  final String days;
  final String identification;
  final String qty;

  const UserDetailsPage(
      {super.key, required this.id,
      required this.name,
      required this.email,
      required this.idStatus,
      required this.access,
      required this.days,
      required this.identification,
      required this.qty});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: $name'),
            Text('Email: $email'),
            Text('Status: $idStatus'),
            Text('Status: $access'),
            Text('Status: $qty'),
            Text('Status: $days'),
            _buildUserImage()
            // Add more details as needed
          ],
        ),
      ),
    );
  }

  Widget _buildUserImage() {
    // Use Image.network to load the image from the URL
    return Image.network(
      'https://guestlist.ocesa.mx/admin/uploads/$identification',
      width: 300, // Set the desired width
      height: 300,
      fit: BoxFit.scaleDown,
    );
  }
}
