import 'package:flutter/material.dart';

PageRoute<T> createRoute<T>(Widget page) {
  return PageRouteBuilder<T>(
    pageBuilder: (context, anim, secondaryAnim) => page,
    transitionsBuilder: (context, anim, secondaryAnim, child) {
      var begin = Offset(1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: anim.drive(tween),
        child: child,
      );
    },
  );
}

PageRoute<T> createModalRoute<T>(Widget page) {
  return PageRouteBuilder<T>(
    pageBuilder: (context, anim, secondaryAnim) => page,
    transitionsBuilder: (context, anim, secondaryAnim, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: anim.drive(tween),
        child: child,
      );
    },
  );
}

PageRoute<T> createNavRoute<T>(Widget page) {
  return PageRouteBuilder<T>(
    pageBuilder: (context, anim, secondaryAnim) => page,
    transitionsBuilder: (context, anim, secondaryAnim, child) {
      var curve = Curves.fastOutSlowIn;
      var tween = Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));
      return FadeTransition(
        opacity: anim.drive(tween),
        child: child,
      );
    },
  );
}