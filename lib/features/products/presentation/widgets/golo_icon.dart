import 'package:flutter/material.dart';

class GoloIcon extends StatelessWidget {
  final Icon icon;
  final void Function()? onTap;
  const GoloIcon({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade500),
        ),
        child: icon,
      ),
    );
  }
}
