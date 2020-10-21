import 'package:moor/moor.dart';

class ProductDiscounts extends Table {
  IntColumn get productId => integer().customConstraint('REFERENCES products(id)')();
  IntColumn get discountId => integer().customConstraint('REFERENCES discounts(id)')();
}