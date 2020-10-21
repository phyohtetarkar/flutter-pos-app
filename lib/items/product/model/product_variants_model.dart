import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:pos_domain/pos_domain.dart';

class ProductVariantsModel extends ChangeNotifier {

  ProductVariantsModel(this._useCase);

  final CheckBarCodeUseCase _useCase;
  final List<VariantDTO> _variants = [];

  UnmodifiableListView<VariantDTO> get variants => UnmodifiableListView(_variants.where((e) => !e.removed));

  List<VariantDTO> get allVariants => _variants;

  set variants(List<VariantDTO> list) {
    _variants.clear();
    _variants.addAll(list);
  }

  void add(VariantDTO dto) {
    _variants.add(dto);
    notifyListeners();
  }

  void replaceAt(int index, VariantDTO dto) {
    _variants.removeAt(index);
    _variants.insert(index, dto);
    notifyListeners();
  }

  void remove(VariantDTO dto) {
    if (dto.id != null) {
      dto.removed = true;
    } else {
      _variants.remove(dto);
    }
    notifyListeners();
  }

  Future<bool> checkBarcodeDuplicate(String code, {int variantId}) {
    return _useCase.checkVariantCodeDuplicate(code, variantId: variantId);
  }

}