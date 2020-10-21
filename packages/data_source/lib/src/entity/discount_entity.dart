import 'package:data_source/data_source.dart';
import 'package:moor/moor.dart';
import 'package:pos_domain/pos_domain.dart';

class Discounts extends Table with Auditor {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  RealColumn get value => real()();

  IntColumn get type => intEnum<DiscountType>()();

}