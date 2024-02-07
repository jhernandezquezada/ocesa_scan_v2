// festival_details.dart

import 'package:flutter/material.dart';
import 'package:ocesa_scan_v2/widgets/bottom_navigation_bar.dart';

class FestivalDetailsScreen extends StatelessWidget {
  final int id;
  final String name;

  const FestivalDetailsScreen({super.key, required this.id, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Festival Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ID: $id'),
            Text('Name: $name'),
            // Agrega más detalles del festival según tus necesidades
          ],
        ),
      ),
      bottomNavigationBar:
          const BottomNavigationBarWidget(), // Agrega la barra de navegación inferior aquí
    );
  }
}
