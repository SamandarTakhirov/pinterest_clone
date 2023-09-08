import 'package:flutter/material.dart';

class CustomButtonIcons extends StatelessWidget {
  final String image;
  final bool isActive;

  const CustomButtonIcons({
    required this.image,
    this.isActive = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36,
      height: 36,
      child: Image(
        width: 36,
        height: 36,
        fit: BoxFit.cover,
        image: AssetImage(image),
        color: isActive ? Colors.red : Colors.white,
      ),
    );
  }
}
