import 'package:flutter/material.dart';
import 'package:latte_pos/main.dart';

PreferredSizeWidget createFlatAppBar({
  @required BuildContext context,
  Widget title,
  List<Widget> actions,
}) {
  return AppBar(
    elevation: 0,
    backgroundColor: bgColor,
    brightness: Brightness.dark,
    textTheme: Theme.of(context).textTheme.copyWith(
          headline3: TextStyle(
            color: Colors.black,
          ),
        ),
    iconTheme: Theme.of(context).iconTheme.copyWith(
          color: Colors.black,
        ),
    title: title,
    bottom: PreferredSize(
      child: Divider(height: 1, color: Colors.grey),
      preferredSize: Size.fromHeight(1),
    ),
    actions: actions,
  );
}
