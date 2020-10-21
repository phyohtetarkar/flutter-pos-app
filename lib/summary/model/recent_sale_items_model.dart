import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:pos_domain/pos_domain.dart';

class RecentSaleItemsModel extends ChangeNotifier {

  RecentSaleItemsModel(this._useCase);

  final GetRecentSaleItemUseCase _useCase;

  List<RecentSaleItemDTO> _recentItems = [];

  UnmodifiableListView<RecentSaleItemDTO> get recentItems => UnmodifiableListView(_recentItems);

  void find() {
    _useCase.getRecentSaleItems().then((list) {
      _recentItems = list;
      notifyListeners();
    });
  }

}