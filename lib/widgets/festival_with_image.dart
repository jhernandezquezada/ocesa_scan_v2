import 'package:flutter/material.dart';

class FestivalWithImage extends StatelessWidget {
  final Widget child;
  final String imageUrl;
  final String imageUrl2;

  const FestivalWithImage(SizedBox sizedBox,
      {super.key, required this.child, required this.imageUrl, required this.imageUrl2});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(imageUrl, height: 200, width: 300, fit: BoxFit.cover),
        const SizedBox(height: 10),
        Image.asset(imageUrl2, height: 100, width: 200, fit: BoxFit.cover),
        const SizedBox(height: 10),
        child,
      ],
    );
  }
}
