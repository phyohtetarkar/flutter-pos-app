import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:pos_domain/pos_domain.dart';

class SaleProductsModel extends ChangeNotifier {

  SaleProductsModel(this._useCase);

  final GetAllProductWithCategoryUseCase _useCase;

  bool _onLoad = false;

  List<ProductDTO> _products = [];

  UnmodifiableListView<ProductDTO> get products => UnmodifiableListView(_products);

  ProductSearch _search = ProductSearch(available: true, limit: 25);

  ProductSearch get search => _search;

  set search(ProductSearch search) {
    _search = search;
    find();
  }

  void find() {
    _onLoad = true;
    _search.offset = 0;
    _useCase.findStatic(_search).then((list) {
      _products = list;
      notifyListeners();
      _onLoad = false;
    });
  }

  void loadMore() {
    if (!_onLoad) {
      _onLoad = true;
      _search.offset += _search.limit;
      _useCase.findStatic(_search).then((list) {
        _products.addAll(list);
        notifyListeners();
        _onLoad = false;
        if (list.isEmpty) {
          _search.offset -= _search.limit;
        }
      });
    }

  }

  @override
  void dispose() {
    super.dispose();
  }

}