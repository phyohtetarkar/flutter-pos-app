import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:pos_domain/pos_domain.dart';

class ReceiptListModel extends ChangeNotifier {

  ReceiptListModel(this._useCase, this._amountUseCase);

  final GetAllSaleUseCase _useCase;
  final GetSaleAmountUseCase _amountUseCase;

  SaleSearch _search = SaleSearch(offset: 0, limit: 25);

  bool _onLoad = false;

  List<SaleDTO> _receipts = [];
  double _totalAmount = 0;

  UnmodifiableListView<SaleDTO> get receipts => UnmodifiableListView(_receipts);

  double get totalAmount => _totalAmount ?? 0;

  SaleSearch get search => _search;

  set code(String code) {
    _search.code = code;
    find();
  }

  set date(DateTime date) {
    _search.date = date;
    find();
  }

  Future find() async {
    _onLoad = true;
    _search.offset = 0;
    _receipts = await _useCase.getAll(_search);
    _totalAmount = await _amountUseCase.getSaleAmount(_search);
    notifyListeners();
    _onLoad = false;
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