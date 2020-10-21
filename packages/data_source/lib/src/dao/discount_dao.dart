import 'package:data_source/data_source.dart';
import 'package:data_source/src/entity/discount_entity.dart';
import 'package:moor/moor.dart';
import 'package:data_source/src/extensions.dart';
import 'package:pos_domain/pos_domain.dart';

part 'discount_dao.g.dart';

@UseDao(tables: [Discounts])
class DiscountDao extends DatabaseAccessor<POSDatabase> with _$DiscountDaoMixin {

  DiscountDao(POSDatabase db) : super(db);

  Future<int> insert(DiscountsCompanion entry) {
    return into(discounts).insert(entry);
  }

  Future modify(DiscountsCompanion entry) {
    return (update(discounts)
      ..where((tb) => tb.id.equals(entry.id.value))
    ).write(
        DiscountsCompanion(
          name: entry.name,
          value: entry.value,
          type: entry.type,
          modifiedAt: entry.modifiedAt,
        )
    );
  }

  Future remove(int id) {
    return (delete(discounts)..where((tb) => tb.id.equals(id))).go();
  }

  Future<DiscountDTO> findById(int id) {
    return (select(discounts)..where((tb) => tb.id.equals(id)))
        .map((d) => d.toData())
        .getSingle();
  }

  Future<DiscountDTO> findByName(String name) {
    return (select(discounts)
      ..where((tb) => tb.name.lower().equals(name.toLowerCase())))
        .map((d) => d.toData())
        .getSingle();
  }

  Stream<List<DiscountDTO>> findAll() {
    final query = select(discounts);

    query.orderBy([(tb) => OrderingTerm.desc(tb.createdAt)]);

    return query.map((d) => d.toData()).watch();
  }

  Future<List<DiscountDTO>> findAllStatic() {
    final query = select(discounts);

    query.orderBy([(tb) => OrderingTerm.desc(tb.createdAt)]);

    return query.map((d) => d.toData()).get();
  }

}