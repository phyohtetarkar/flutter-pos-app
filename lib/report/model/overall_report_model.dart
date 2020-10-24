import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:pos_domain/pos_domain.dart';

class OverallReportModel extends ChangeNotifier {

  OverallReportModel(this._useCase);

  final GetOverallSaleReport _useCase;

  double _totalPrice = 0;
  double _totalCost = 0;
  List<SaleByCategoryDTO> _salesByCategory = [];

  double get totalPrice => _totalPrice;

  double get totalProfit => _totalPrice - _totalCost;

  double get totalSaleByCategory => _salesByCategory.map((e) => e.totalPrice).fold(0, (pv, e) => pv + e);

  UnmodifiableListView<SaleByCategoryDTO> get salesByCategory => UnmodifiableListView(_salesByCategory);

  void find() {
    _useCase.getOverallReport().then((value) {
      _totalPrice = value.totalPrice ?? 0;
      _totalCost = value.totalCost ?? 0;
      _salesByCategory = value.list;
      notifyListeners();
    });
  }

}