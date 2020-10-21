import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:pos_domain/pos_domain.dart';

class ProductTaxesModel extends ChangeNotifier {

  final List<TaxDTO> _taxes = [];

  UnmodifiableListView<TaxDTO> get taxes => UnmodifiableListView(_taxes);

  set taxes(List<TaxDTO> list) {
    _taxes.clear();
    _taxes.addAll(list);
  }

  void addAll(List<TaxDTO> list) {
    taxes = list;
    notifyListeners();
  }

  void add(TaxDTO tax) {
    _taxes.add(tax);
    notifyListeners();
  }

  void remove(TaxDTO tax) {
    _taxes.removeWhere((e) => e.id == tax.id);
    notifyListeners();
  }

}