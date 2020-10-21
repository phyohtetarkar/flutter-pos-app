import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:pos_domain/pos_domain.dart';

class ReceiptListModel extends ChangeNotifier {

  ReceiptListModel(this._useCase);

  final GetAllSaleUseCase _useCase;

  SaleSearch _search = SaleSearch(offset: 0, limit: 25);

  bool _onLoad = false;

  List<SaleDTO> _receipts = [];

  UnmodifiableListView<SaleDTO> get receipts => UnmodifiableListView(_receipts);

  SaleSearch get search => _search;

  set code(String code) {
    _search.code = code;
    find();
  }

  void find() {
    _onLoad = true;
    _search.offset = 0;
    _useCase.getAll(_search).then((list) {
      _receipts = list;
      notifyListeners();
      _onLoad = false;
    });
  }

  void loadMore() {
    if (!_onLoad) {
      _onLoad = true;
      _search.offset += _search.limit;
      _useCase.getAll(_search).then((list) {
        _receipts.addAll(list);
        notifyListeners();
        _onLoad = false;
        if (list.isEmpty) {
          _search.offset -= _search.limit;
        }
      });
    }
  }

}