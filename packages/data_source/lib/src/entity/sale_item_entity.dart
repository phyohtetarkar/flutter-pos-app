import 'package:data_source/src/pos_database.dart';
import 'package:moor/moor.dart';

class SaleItems extends Table with Auditor {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get productId => integer()();

  IntColumn get variantId => integer().nullable()();

  TextColumn get productName => text()();

  TextColumn get variantName => text().nullable()();

  RealColumn get price => real()();

  RealColumn get cost => real().nullable()();

  IntColumn get quantity => integer()();

  RealColumn get discount => real().nullable()();

  RealColumn get tax => real().nullable()();

  IntColumn get saleId => integer().customConstraint('REFERENCES sales(id)')();
}

class SaleItemWithProduct {
  final SaleItem item;
  final Product product;
  final Variant variant;

  SaleItemWithProduct(
    this.item,
    this.product,
    this.variant,
  );
}
