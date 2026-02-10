import 'package:flutter/material.dart';

class TitleRowWidget extends StatelessWidget {
  final String title;
  final String seeAllTxt;

  final void Function()? seeAllTap;
  const TitleRowWidget({
    super.key,
    required this.title,
    required this.seeAllTxt,
    this.seeAllTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: seeAllTap,
          child: Text(
            seeAllTxt,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
        ),
      ],
    );
  }
}
