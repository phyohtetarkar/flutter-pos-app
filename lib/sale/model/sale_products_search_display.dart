import 'package:flutter/material.dart';

class SaleProductsSearchDisplay extends ChangeNotifier {
  bool _searchState = false;

  bool get searchState => _searchState;

  set searchState(bool state) {
    _searchState = state;
    notifyListeners();
  }

}