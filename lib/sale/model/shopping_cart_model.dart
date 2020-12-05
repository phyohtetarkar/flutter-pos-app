import 'dart:collection';

import 'package:data_source/data_source.dart';
import 'package:flutter/material.dart';
import 'package:pos_domain/pos_domain.dart';

class ShoppingCartModel extends ChangeNotifier {
  ShoppingCartModel(
    this._buildItemUseCase,
    this._barCodeUseCase,
    this._createSaleUseCase,
    this._database,
  );

  final BuildSaleItemUseCase _buildItemUseCase;
  final GetBarCodeUseCase _barCodeUseCase;
  final CreateSaleUseCase _createSaleUseCase;
  final POSDatabase _database;

  List<SaleItemDTO> _items = [];
  double _discount = 0;
  double _tax = 0;
  double _subTotalPrice = 0;
  double _totalPrice = 0;
  double _totalCost = 0;
  int _totalItem = 0;
  double change;
  int payPrice;

  UnmodifiableListView<SaleItemDTO> get items => UnmodifiableListView(_items.where((e) => !e.removed));

  double get discount => _discount;

  double get tax => _tax;

  double get subTotalPrice => _subTotalPrice;

  double get totalSalePrice => _totalPrice + _tax;

  int get totalItem => _totalItem;

  void setPayPrice(int price) {
    payPrice = price;
    if (price != null) {
      change = payPrice - totalSalePrice;
    } else {
      change = null;
    }

    notifyListeners();
  }

  Future<int> createSale() {
    return _database.transaction(() async {
      SaleDTO sale = SaleDTO(
        totalPrice: _totalPrice,
        subTotalPrice: _subTotalPrice,
        discount: _discount > 0 ? _discount : null,
        tax: _tax > 0 ? _tax : null,
        totalCost: _totalCost,
        payPrice: payPrice?.toDouble(),
        change: change,
      );

      return _createSaleUseCase.create(sale, _items);
    });
  }

  void add(SaleItemDTO dto) {
    final old = _items.firstWhere((e) => e.productId == dto.productId && e.variantId == dto.variantId && e.discount == dto.discount, orElse: () => null);
    if (old != null && !old.removed) {
      old.quantity += 1;
    } else {
      _items.add(dto);
    }

    _calculate();
    notifyListeners();
  }

  Future addById(int productId) async {
    final item = await _buildItemUseCase.buildSaleItemById(productId);
    final old = _items.firstWhere((e) => e.productId == productId && e.variantId == null && e.discount == item.discount, orElse: () => null);
    if (old != null && !old.removed) {
      old.quantity += 1;
    } else {
      _items.add(item);
    }
    _calculate();
    notifyListeners();
  }

  Future addByBarcode(String code) async {
    final barCode = await _barCodeUseCase.getBarCode(code);

    if (barCode == null) {
      return Future.error("Product not found.");
    }

    final item = await _buildItemUseCase.buildSaleItemByCode(code);

    if (item == null) {
      return Future.error("Product not found.");
    }

    final old = _items.firstWhere((e) => e.productId == barCode.productId && e.variantId == barCode.variantId && e.discount == item.discount, orElse: () => null);

    if (old != null && !old.removed) {
      old.quantity += 1;
    } else {
      final item = await _buildItemUseCase.buildSaleItemByCode(code);
      _items.add(item);
    }

    _calculate();
    notifyListeners();
  }

  void update(SaleItemDTO item, int index) {
    _items.removeAt(index);
    _items.insert(index, item);

    _calculate();
    notifyListeners();
  }

  void removeAt(int index) {
    _items[index].removed = true;

    _calculate();
    notifyListeners();
  }

  void remove(SaleItemDTO item) {
    //final item = _items.firstWhere((e) => !e.removed && e.productId == productId && e.variantId == variantId, orElse: () => null);

    if (item != null && item.id != null) {
      item.removed = true;
    } else {
      _items.remove(item);
    }

    _calculate();
    notifyListeners();
  }

  void removeAll() {
    _items = [];
    _calculate();
    notifyListeners();
  }

  void reset() {
    change = null;
    payPrice = null;
    removeAll();
  }

  void _calculate() {
    _discount = 0;
    _tax = 0;
    _subTotalPrice = 0;
    _totalPrice = 0;
    _totalItem = 0;
    _totalCost = 0;

    for (SaleItemDTO item in items) {
      _discount += item.computedDiscount;
      _tax += item.computedTax;
      _subTotalPrice += (item.total);
      _totalPrice = (_subTotalPrice - _discount);
      _totalItem += item.quantity;
      _totalCost += item.totalCost ?? 0;
    }
  }
}
