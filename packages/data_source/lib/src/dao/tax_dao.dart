import 'package:data_source/data_source.dart';
import 'package:data_source/src/entity/tax_entity.dart';
import 'package:moor/moor.dart';
import 'package:pos_domain/pos_domain.dart';
import 'package:data_source/src/extensions.dart';

part 'tax_dao.g.dart';

@UseDao(tables: [Taxes])
class TaxDao extends DatabaseAccessor<POSDatabase> with _$TaxDaoMixin {

  TaxDao(POSDatabase db) : super(db);

  Future<int> insert(TaxesCompanion entry) {
    return into(taxes).insert(entry);
  }

  Future modify(TaxesCompanion entry) {
    return (update(taxes)
      ..where((tb) => tb.id.equals(entry.id.value))
    ).write(
        TaxesCompanion(
          name: entry.name,
          value: entry.value,
          modifiedAt: entry.modifiedAt,
        )
    );
  }

  Future remove(int id) {
    return (delete(taxes)..where((tb) => tb.id.equals(id))).go();
  }

  Future<TaxDTO> findById(int id) {
    return (select(taxes)..where((tb) => tb.id.equals(id)))
        .map((t) => t.toData())
        .getSingle();
  }

  Future<TaxDTO> findByName(String name) {
    return (select(taxes)
      ..where((tb) => tb.name.lower().equals(name.toLowerCase())))
        .map((t) => t.toData())
        .getSingle();
  }

  Stream<List<TaxDTO>> findAll() {
    final query = select(taxes);

    query.orderBy([(tb) => OrderingTerm.desc(tb.createdAt)]);

    return query.map((t) => t.toData()).watch();
  }

}