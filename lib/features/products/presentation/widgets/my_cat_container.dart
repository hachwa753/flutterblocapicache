import 'package:flutter/material.dart';

class MyCatContainer extends StatelessWidget {
  final String catTitle;
  const MyCatContainer({super.key, required this.catTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.deepOrangeAccent,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.only(right: 7),
      child: Center(
        child: Text(
          catTitle,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
