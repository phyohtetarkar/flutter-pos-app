import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:pos_domain/pos_domain.dart';

class ReceiptDetailModel extends ChangeNotifier {

  ReceiptDetailModel(this._detailUseCase);

  final GetSaleDetailUseCase _detailUseCase;

  SaleDetailDTO _detail;

  SaleDTO get sale => _detail?.sale;

  UnmodifiableListView<SaleItemDTO> get items => UnmodifiableListView(_detail?.items ?? []);

  void findDetail(int saleId) {
    _detailUseCase.getSaleDetail(saleId).then((value) {
      _detail = value;
      notifyListeners();
    });
  }

}