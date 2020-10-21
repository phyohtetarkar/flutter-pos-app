import 'dart:io';

import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pos_domain/pos_domain.dart';

import 'dao/category_dao.dart';
import 'dao/discount_dao.dart';
import 'dao/product_dao.dart';
import 'dao/sale_dao.dart';
import 'dao/tax_dao.dart';
import 'entity/category_entity.dart';
import 'entity/discount_entity.dart';
import 'entity/product_bar_code_entity.dart';
import 'entity/product_discount_entity.dart';
import 'entity/product_entity.dart';
import 'entity/product_tax_entity.dart';
import 'entity/sale_entity.dart';
import 'entity/sale_item_entity.dart';
import 'entity/tax_entity.dart';
import 'entity/variant_entity.dart';

part 'pos_database.g.dart';

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'pos-database.db'));
    return VmDatabase(file);
  });
}

mixin Auditor on Table {
  IntColumn get createdAt => integer()();
  IntColumn get modifiedAt => integer()();
}

@UseMoor(
  tables: [
    Categories,
    Discounts,
    Taxes,
    Products,
    Variants,
    ProductDiscounts,
    ProductTaxes,
    ProductBarCodes,
    Sales,
    SaleItems,
  ],
  daos: [
    CategoryDao,
    DiscountDao,
    TaxDao,
    ProductDao,
    SaleDao,
  ],
)
class POSDatabase extends _$POSDatabase {
  POSDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON;');
      },
    );
  }
}