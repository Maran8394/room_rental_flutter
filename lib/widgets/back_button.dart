import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final Color? color;
  const CustomBackButton({
    Key? key,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(Icons.arrow_back_ios, color: color),
    );
  }
}
