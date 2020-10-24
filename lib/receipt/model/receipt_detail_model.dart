import 'dart:collection';

import 'package:data_source/data_source.dart';
import 'package:flutter/material.dart';
import 'package:pos_domain/pos_domain.dart';

class ReceiptDetailModel extends ChangeNotifier {

  ReceiptDetailModel(this._detailUseCase, this._deleteUseCase, this._database);

  final GetSaleDetailUseCase _detailUseCase;
  final DeleteSaleUseCase _deleteUseCase;
  final POSDatabase _database;

  SaleDetailDTO _detail;

  SaleDTO get sale => _detail?.sale;

  UnmodifiableListView<SaleItemDTO> get items => UnmodifiableListView(_detail?.items ?? []);

  void findDetail(int saleId) {
    _detailUseCase.getSaleDetail(saleId).then((value) {
      _detail = value;
      notifyListeners();
    });
  }

  Future deleteSale(int saleId) {
    return _database.transaction(() async {
      await _deleteUseCase.delete(saleId);
    });
  }

}