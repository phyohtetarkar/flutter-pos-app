import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:pos_domain/pos_domain.dart';

class SummaryChartDataModel extends ChangeNotifier {
  SummaryChartDataModel(this._useCase);

  final GetWeeklySalesUseCase _useCase;

  Map<int, double> _entries = {};

  UnmodifiableMapView<int, double> get entries => UnmodifiableMapView(_entries);

  void find() {
    _useCase.getWeeklySales().then((map) {
      _entries = map;
      notifyListeners();
    });
  }

}