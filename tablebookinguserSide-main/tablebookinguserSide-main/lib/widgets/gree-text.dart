import 'package:flutter/material.dart';

class GreenText extends StatelessWidget {
  String text;
  Color color;
  double size;
  GreenText(
      {super.key,
      required this.text,
      this.color = Colors.green,
      this.size = 24});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: size),
    );
  }
}

class GreyText extends StatelessWidget {
  String text;
  Color color;
  double size;
  GreyText(
      {super.key,
      required this.text,
      this.color = Colors.grey,
      this.size = 14});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: size,),
    );
  }
}
