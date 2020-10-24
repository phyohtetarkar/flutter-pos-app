import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:pos_domain/pos_domain.dart';

class SaleByYearModel extends ChangeNotifier {

  SaleByYearModel(this._useCase);

  final GetMonthlySaleUseCase _useCase;

  Map<int, double> _entries = {};

  UnmodifiableMapView<int, double> get entries => UnmodifiableMapView(_entries);

  void find(int year) {
    _useCase.getMonthlySales(year).then((map) {
      _entries = map;
      notifyListeners();
    });
  }
}