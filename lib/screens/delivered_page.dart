import 'package:flutter/material.dart';

class DeliveredPage extends StatelessWidget {
  const DeliveredPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivered'),
      ),
      body: const Center(
        child: Text('Delivered Page Content'),
      ),
    );
  }
}
