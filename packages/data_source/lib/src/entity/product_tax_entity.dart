import 'package:moor/moor.dart';

@DataClassName("ProductTax")
class ProductTaxes extends Table {
  IntColumn get productId => integer().customConstraint('REFERENCES products(id)')();
  IntColumn get taxId => integer().customConstraint('REFERENCES taxes(id)')();
}