import 'package:flutter/material.dart';

class ProductSearchDisplay extends ChangeNotifier {
  bool _searchState = false;

  bool get searchState => _searchState;

  set searchState(bool state) {
    _searchState = state;
    notifyListeners();
  }

}