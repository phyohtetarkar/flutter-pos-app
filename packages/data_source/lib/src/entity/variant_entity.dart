import 'package:data_source/data_source.dart';
import 'package:moor/moor.dart';

class Variants extends Table with Auditor {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  RealColumn get price => real()();

  RealColumn get cost => real().nullable()();

  BoolColumn get available => boolean()();

  IntColumn get productId => integer().customConstraint('REFERENCES products(id)')();
}

class VariantWithBarCode {
  final Variant variant;
  final ProductBarCode barCode;

  VariantWithBarCode(
    this.variant,
    this.barCode,
  );
}
