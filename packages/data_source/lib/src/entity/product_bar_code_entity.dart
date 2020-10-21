import 'package:moor/moor.dart';

class ProductBarCodes extends Table {
  TextColumn get code => text()();

  IntColumn get productId => integer().customConstraint('REFERENCES products(id)')();

  IntColumn get variantId => integer().nullable()();

  @override
  Set<Column> get primaryKey => {code};
}