import 'package:flutter/material.dart';
import 'package:pos_domain/pos_domain.dart';

class ProductCategoryModel extends ChangeNotifier {

  CategoryDTO category;

  void setCategory(CategoryDTO dto) {
    category = dto;
    notifyListeners();
  }

}