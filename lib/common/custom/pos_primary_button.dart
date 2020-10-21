import 'package:flutter/material.dart';
import 'package:latte_pos/main.dart';

class POSPrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final EdgeInsetsGeometry padding;
  final double elevation;
  final Color color;
  final Color textColor;

  const POSPrimaryButton({
    Key key,
    this.onPressed,
    this.text,
    this.padding,
    this.elevation,
    this.color = primaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: RaisedButton(
        onPressed: onPressed,
        color: color,
        elevation: elevation,
        focusElevation: elevation,
        highlightElevation: elevation,
        disabledElevation: elevation,
        hoverElevation: elevation,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        //padding: padding,
        textColor: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
