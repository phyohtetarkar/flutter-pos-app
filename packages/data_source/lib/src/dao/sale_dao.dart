import 'package:data_source/data_source.dart';
import 'package:data_source/src/entity/category_entity.dart';
import 'package:data_source/src/entity/product_entity.dart';
import 'package:data_source/src/entity/sale_entity.dart';
import 'package:data_source/src/entity/sale_item_entity.dart';
import 'package:data_source/src/entity/variant_entity.dart';
import 'package:moor/moor.dart';
import 'package:pos_domain/pos_domain.dart';

part 'sale_dao.g.dart';

@UseDao(tables: [
  Sales,
  SaleItems,
  Products,
  Variants,
  Categories,
])
class SaleDao extends DatabaseAccessor<POSDatabase> with _$SaleDaoMixin {
  SaleDao(POSDatabase db) : super(db);

  Future<int> insertSale(SalesCompanion entry) {
    return into(sales).insert(entry);
  }

  Future<int> insertSaleItem(SaleItemsCompanion entry) {
    return into(saleItems).insert(entry);
  }

  Future insertSaleCode(int saleId, String code) {
    return (update(sales)..where((tb) => tb.id.equals(saleId))).write(SalesCompanion(
      code: Value(code),
    ));
  }

  Future removeSale(int id) {
    return (delete(sales)..where((tb) => tb.id.equals(id))).go();
  }

  Future removeSaleItem(int id) {
    return (delete(saleItems)..where((tb) => tb.id.equals(id))).go();
  }

  Future removeSaleItemBySale(int saleId) {
    return (delete(saleItems)..where((tb) => tb.saleId.equals(saleId))).go();
  }

  Future<Sale> getSale(int saleId) {
    return (select(sales)..where((tb) => tb.id.equals(saleId))).getSingle();
  }

  Future<List<SaleItem>> getSaleItems(int saleId) {
    return (select(saleItems)..where((tb) => tb.saleId.equals(saleId))).get();
  }

  Future<List<SaleWithItemCount>> findStatic(SaleSearch search) {
    final itemCount = saleItems.id.count();
    final query = select(sales).join([
      leftOuterJoin(saleItems, saleItems.saleId.equalsExp(sales.id)),
    ]);

    query
      ..addColumns([itemCount])
      ..groupBy([sales.id]);

    if ((search.limit ?? 0) > 0) {
      query.limit(search.limit, offset: search.offset);
    }

    query.orderBy([OrderingTerm.desc(sales.createdAt)]);

    return query.get().then((rows) {
      return rows.map((row) {
        return SaleWithItemCount(
          row.readTable(sales),
          row.read(itemCount),
        );
      }).toList();
    });
  }

  Future<List<SaleItemWithProduct>> getRecentSaleItems(int limit) {
    final query = select(saleItems).join([
      leftOuterJoin(products, products.id.equalsExp(saleItems.productId)),
      leftOuterJoin(variants, variants.id.equalsExp(saleItems.variantId)),
    ]);

    var dt = DateTime.now();

    var from = DateTime(dt.year, dt.month, dt.day).toUtc().millisecondsSinceEpoch;
    var to = DateTime(dt.year, dt.month, dt.day, 23, 59, 59).toUtc().millisecondsSinceEpoch;

    query.where(
      saleItems.createdAt.isBetween(Variable.withInt(from), Variable.withInt(to)),
    );

    query.orderBy([OrderingTerm.desc(saleItems.createdAt)]);

    if (limit != null) {
      query.limit(limit, offset: 0);
    }

    return query.get().then((rows) {
      return rows.map((row) {
        return SaleItemWithProduct(
          row.readTable(saleItems),
          row.readTable(products),
          row.readTable(variants),
        );
      }).toList();
    });
  }

  Future<List<DistinctSaleItem>> getDistinctSaleItems({DateTime dateTime}) {
    final productName = saleItems.productName;
    final variantName = saleItems.variantName;
    final totalPrice = saleItems.totalPrice.sum();
    final totalQuantity = saleItems.quantity.sum();

    final query = select(saleItems).join([
      leftOuterJoin(products, products.id.equalsExp(saleItems.productId)),
      leftOuterJoin(variants, variants.id.equalsExp(saleItems.variantId)),
    ]);

    query
      ..addColumns([productName, variantName, totalPrice, totalQuantity])
      ..groupBy([saleItems.productId, saleItems.variantId]);

    var dt = dateTime ?? DateTime.now();

    var from = DateTime(dt.year, dt.month, dt.day).toUtc().millisecondsSinceEpoch;
    var to = DateTime(dt.year, dt.month, dt.day, 23, 59, 59).toUtc().millisecondsSinceEpoch;

    query.where(
      saleItems.createdAt.isBetween(Variable.withInt(from), Variable.withInt(to)),
    );

    query.orderBy([OrderingTerm.asc(saleItems.productName)]);

    return query.get().then((rows) {
      return rows.map((row) {
        final product = row.readTable(products);
        final variant = row.readTable(variants);
        return DistinctSaleItem(
          product: product?.name ?? row.read(productName),
          variant: variant?.name ?? row.read(variantName),
          image: product?.image,
          price: row.read(totalPrice),
          quantity: row.read(totalQuantity),
        );
      }).toList();
    });
  }

  Future<List<SaleByCategory>> getSaleByCategory() {
    final totalPrice = saleItems.totalPrice.sum();

    final query = select(saleItems).join([
      leftOuterJoin(products, products.id.equalsExp(saleItems.productId)),
      leftOuterJoin(categories, categories.id.equalsExp(products.categoryId)),
    ]);

    query
      ..addColumns([totalPrice])
      ..groupBy([categories.id]);

    return query.get().then((rows) {
      return rows.map((row) {
        return SaleByCategory(
          row.read(totalPrice),
          row.readTable(categories),
        );
      }).toList();
    });
  }

  Future<TotalSaleBalance> getTotalSaleBalance() {
    final totalPrice = sales.totalPrice.sum();
    final totalCost = sales.totalCost.sum();

    final query = selectOnly(sales);

    query
      ..addColumns([totalPrice, totalCost]);

    return query.getSingle().then((row) {
      return TotalSaleBalance(
        totalPrice: row.read(totalPrice),
        totalCost: row.read(totalCost) ?? 0,
      );
    });

  }

  Future<List<MonthlySale>> getMonthlySales([int year]) {
    final month = sales.month;
    final sumOfTotalPrices = sales.totalPrice.sum();

    final query = selectOnly(sales);

    query.where(sales.year.equals(year));

    query
      ..addColumns([month, sumOfTotalPrices])
      ..groupBy([sales.year, sales.month]);

    return query.get().then((rows) {
      return rows.map((row) {
        return MonthlySale(
          row.read(month),
          row.read(sumOfTotalPrices),
        );
      }).toList();
    });

  }

  Future<List<Sale>> getWeeklySales({int from, int to}) {
    final query = select(sales);

    query.where((tb) => tb.createdAt.isBetween(Variable.withInt(from), Variable.withInt(to)));

    return query.get();

  }
}
