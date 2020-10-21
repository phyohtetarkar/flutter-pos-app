import 'package:data_source/src/entity/category_entity.dart';
import 'package:data_source/src/entity/product_entity.dart';
import 'package:data_source/src/pos_database.dart';
import 'package:moor/moor.dart';
import 'package:pos_domain/pos_domain.dart';
import 'package:data_source/src/extensions.dart';

part 'category_dao.g.dart';

@UseDao(tables: [Categories, Products])
class CategoryDao extends DatabaseAccessor<POSDatabase> with _$CategoryDaoMixin {
  CategoryDao(POSDatabase db) : super(db);

  Future<int> insert(CategoriesCompanion entry) {
    return into(categories).insert(entry);
  }

  Future modify(CategoriesCompanion entry) {
    return (update(categories)
      ..where((tb) => tb.id.equals(entry.id.value))
    ).write(
        CategoriesCompanion(
          name: entry.name,
          color: entry.color,
          modifiedAt: entry.modifiedAt,
        )
    );
  }

  Future remove(int id) {
    return (delete(categories)..where((tb) => tb.id.equals(id))).go();
  }

  Future<CategoryDTO> findById(int id) {
    return (select(categories)..where((tb) => tb.id.equals(id)))
        .map((c) => c.toData())
        .getSingle();
  }

  Future<CategoryDTO> findByName(String name) {
    return (select(categories)
      ..where((tb) => tb.name.lower().equals(name.toLowerCase())))
        .map((c) => c.toData())
        .getSingle();
  }

  Stream<List<CategoryDTO>> findAll() {
    final query = select(categories);

    // var dt = DateTime.now();
    //
    // var from = DateTime(dt.year, dt.month, dt.day).toUtc().millisecondsSinceEpoch;
    // var to = DateTime(dt.year, dt.month, dt.day, 23, 59, 59).toUtc().millisecondsSinceEpoch;
    //
    // query..where((tb) {
    //   return tb.createdAt.isBetween(Variable.withInt(from), Variable.withInt(to));
    // });
    //print("from: $from");
    //print("to: $to");

    query.orderBy([(tb) => OrderingTerm.asc(tb.name.lower())]);

    return query.map((c) {
      //print(c.color.toRadixString(16));
      return c.toData();
    }).watch();
  }

  Future<List<CategoryDTO>> findAllStatic() {
    final query = select(categories);
    
    query.orderBy([(tb) => OrderingTerm.asc(tb.name.lower())]);

    return query.map((c) => c.toData()).get();
  }

  Stream<List<CategoryWithProductCount>> findAllWithProductCount() {
    final productCount = products.id.count();

    final query = (select(categories)..orderBy([(tb) => OrderingTerm.asc(tb.name.lower())])).join([
      leftOuterJoin(products, products.categoryId.equalsExp(categories.id)),
    ]);

     query
        ..addColumns([productCount])
        ..groupBy([categories.id]);

    return query.watch().map((rows) {
      return rows.map((row) {
        return CategoryWithProductCount(
          row.readTable(categories),
          row.read(productCount),
        );
      }).toList();
    });
  }
}