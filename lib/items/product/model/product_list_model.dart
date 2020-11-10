import 'dart:collection';
import 'dart:io';

import 'package:data_source/data_source.dart';
import 'package:flutter/material.dart';
import 'package:latte_pos/main.dart';
import 'package:pos_domain/pos_domain.dart';
import 'package:path_provider/path_provider.dart';

class ProductListModel extends ChangeNotifier {

  ProductListModel(
    this._findAllUseCase,
    this._deleteUseCase,
    this._database,
  );

  final POSDatabase _database;
  final GetAllProductWithCategoryUseCase _findAllUseCase;
  final DeleteProductUseCase _deleteUseCase;

  ProductSearch _search = ProductSearch(offset: 0, limit: 15);

  bool _onLoad = false;

  List<ProductDTO> _products = [];

  UnmodifiableListView<ProductDTO> get products => UnmodifiableListView(_products);

  ProductSearch get search => _search;

  set search(ProductSearch search) {
    _search = search;
    findStatic();
  }

  Stream<List<ProductDTO>> find() {
    return _findAllUseCase.find(_search);
  }

  void findStatic() {
    _onLoad = true;
    _search.offset = 0;
    _findAllUseCase.findStatic(_search).then((list) {
      _products = list;
      notifyListeners();
      _onLoad = false;
    });
  }

  void loadMore() {
    if (!_onLoad) {
      _onLoad = true;
      _search.offset += _search.limit;
      _findAllUseCase.findStatic(_search).then((list) {
        _products.addAll(list);
        notifyListeners();
        _onLoad = false;
        if (list.isEmpty) {
          _search.offset -= _search.limit;
        }
      });
    }
  }

  void remove(int id) {
    _products.removeWhere((p) => p.id == id);
    notifyListeners();
  }

  Future delete(int id, {String image}) {
    return _database.transaction(() async {
      await _deleteUseCase.delete(id);
      if (image != null) {
        final doc = await getApplicationDocumentsDirectory();
        final dir = Directory("${doc.path}/$imageRoot");
        final file = File("${dir.path}/$image");
        final exist = await file.exists();
        if (exist) {
          await file.delete();
        }
      }
    });
  }
}
