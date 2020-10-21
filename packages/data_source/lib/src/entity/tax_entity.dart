import 'package:data_source/data_source.dart';
import 'package:moor/moor.dart';

@DataClassName("Tax")
class Taxes extends Table with Auditor {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  RealColumn get value => real()();
}