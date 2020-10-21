import 'package:data_source/src/pos_database.dart';
import 'package:moor/moor.dart';

@DataClassName("Category")
class Categories extends Table with Auditor {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  IntColumn get color => integer()();
}

class CategoryWithProductCount {
  final Category category;
  final int count;

  CategoryWithProductCount(
    this.category,
    this.count,
  );
}
