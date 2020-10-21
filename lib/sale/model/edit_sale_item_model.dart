import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:pos_domain/pos_domain.dart';

class EditSaleItemModel extends ChangeNotifier {
  EditSaleItemModel(
    this._productByIdUseCase,
    this._allDiscountUseCase,
  );

  final GetProductByIdUseCase _productByIdUseCase;
  final GetAllDiscountUseCase _allDiscountUseCase;

  SaleItemDTO _item;

  List<VariantDTO> _variants = [];

  List<DiscountDTO> _discounts = [];

  VariantDTO selectedVariant;

  UnmodifiableListView<VariantDTO> get variants => UnmodifiableListView(_variants.where((e) => e.available));

  UnmodifiableListView<DiscountDTO> get discounts => UnmodifiableListView(_discounts);

  UnmodifiableListView<DiscountDTO> get selectedDiscounts => UnmodifiableListView(_item.discounts);

  SaleItemDTO get item => _item;

  Future init(SaleItemDTO item) async {
    // search all discounts
    final list = await _allDiscountUseCase.getAllStatic();
    _discounts = list ?? [];

    // search product
    final product = await _productByIdUseCase.getProduct(item.productId);
    //_item.discounts = product.discounts ?? [];
    _variants = product.variants ?? [];

    if (item.variantId != null) {
      selectedVariant = variants.firstWhere((e) => e.id == item.variantId);
    } else if (variants.isNotEmpty) {
      selectedVariant = variants[0];
    }

    _item = item;

    if (_item.discounts == null) {
      _item.discounts = product.discounts ?? [];
    }

    notifyListeners();
  }

  SaleItemDTO getUpdatedItem() {
    if (selectedVariant != null) {
      _item.variantId = selectedVariant.id;
      _item.price = selectedVariant.price;
      _item.cost = selectedVariant.cost;
      _item.variantName = selectedVariant.name;
    }

    _item.discount = selectedDiscounts.map((e) {
          if (e.type == DiscountType.percentage) {
            return e.value / 100;
          }
          return ((e.value * 100) / _item.price) / 100;
        }).fold(0, (pv, e) => pv + e);

    return _item;
  }

  void addDiscount(DiscountDTO dto) {
    _item.discounts.add(dto);
  }

  void removeDiscount(int id) {
    _item.discounts.removeWhere((e) => e.id == id);
  }

}
