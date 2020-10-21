import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:pos_domain/pos_domain.dart';

class ProductDiscountsModel extends ChangeNotifier {

  final List<DiscountDTO> _discounts = [];

  UnmodifiableListView<DiscountDTO> get discounts => UnmodifiableListView(_discounts);

  set discounts(List<DiscountDTO> list) {
    _discounts.clear();
    _discounts.addAll(list);
  }

  void add(DiscountDTO discount) {
    _discounts.add(discount);
    notifyListeners();
  }

  void addAll(List<DiscountDTO> list) {
    discounts = list;
    notifyListeners();
  }

  void remove(DiscountDTO discount) {
    _discounts.removeWhere((e) => e.id == discount.id);
    notifyListeners();
  }

}