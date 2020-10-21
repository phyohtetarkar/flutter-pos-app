import 'package:data_source/data_source.dart';
import 'package:moor/moor.dart';

class Products extends Table with Auditor {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  RealColumn get price => real().nullable()();

  RealColumn get cost => real().nullable()();

  TextColumn get image => text().nullable()();

  BoolColumn get available => boolean()();

  IntColumn get categoryId => integer().customConstraint('REFERENCES categories(id)')();
}

class ProductWithCategory {
  final Product product;
  final Category category;
  final int variant;

  ProductWithCategory(
    this.product,
    this.category,
    this.variant,
  );
}

class ProductDetail {
  final Product product;
  final Category category;
  final List<Variant> variants;
  final List<Discount> discounts;
  final List<Tax> taxes;

  ProductDetail(
    this.product,
    this.category,
    this.variants,
    this.discounts,
    this.taxes,
  );
}
