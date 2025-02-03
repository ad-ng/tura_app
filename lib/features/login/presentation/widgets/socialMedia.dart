import 'package:flutter/material.dart';

class Socialmedia extends StatelessWidget {
  const Socialmedia({super.key, required this.imageUrl});
  final imageUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Image.asset(
          imageUrl,
          height: 30,
        ),
      ),
    );
  }
}
