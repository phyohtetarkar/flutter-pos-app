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

  ProductSearch _search = ProductSearch();

  ProductSearch get search => _search;

  set search(ProductSearch search) {
    _search = search;
    notifyListeners();
  }

  Stream<List<ProductDTO>> find() {
    return _findAllUseCase.find(_search);
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
