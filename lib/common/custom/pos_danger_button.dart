import 'package:flutter/material.dart';
import 'package:latte_pos/main.dart';

class POSDangerButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final EdgeInsetsGeometry padding;
  final double elevation;

  const POSDangerButton({
    Key key,
    this.onPressed,
    this.text,
    this.padding,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: padding,
      onPressed: onPressed,
      color: dangerColor,
      elevation: elevation,
      focusElevation: elevation,
      highlightElevation: elevation,
      disabledElevation: elevation,
      hoverElevation: elevation,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      textColor: Colors.white,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
