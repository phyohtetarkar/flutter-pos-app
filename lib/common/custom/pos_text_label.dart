import 'package:flutter/material.dart';

class POSTextLabel extends StatelessWidget {
  final String label;
  final Color textColor;
  final double textSize;

  const POSTextLabel(
    this.label, {
    Key key,
    this.textColor = Colors.black,
    this.textSize = 15.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: textColor,
        fontSize: textSize,
      ),
    );
  }
}
