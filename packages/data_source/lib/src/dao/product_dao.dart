import 'package:data_source/src/entity/category_entity.dart';
import 'package:data_source/src/entity/discount_entity.dart';
import 'package:data_source/src/entity/product_bar_code_entity.dart';
import 'package:data_source/src/entity/product_discount_entity.dart';
import 'package:data_source/src/entity/product_entity.dart';
import 'package:data_source/src/entity/product_tax_entity.dart';
import 'package:data_source/src/entity/tax_entity.dart';
import 'package:data_source/src/entity/variant_entity.dart';
import 'package:data_source/src/pos_database.dart';
import 'package:moor/moor.dart';
import 'package:pos_domain/pos_domain.dart';

part 'product_dao.g.dart';

@UseDao(tables: [
  Products,
  Variants,
  ProductDiscounts,
  ProductTaxes,
  Categories,
  Discounts,
  Taxes,
  ProductBarCodes,
])
class ProductDao extends DatabaseAccessor<POSDatabase> with _$ProductDaoMixin {
  ProductDao(POSDatabase db) : super(db);

  Future<int> insert(ProductsCompanion entry) {
    return into(products).insert(entry);
  }

  Future<int> insertVariant(VariantsCompanion entry) {
    return into(variants).insert(entry);
  }

  Future<int> insertProductDiscount(ProductDiscount entry) {
    return into(productDiscounts).insert(entry);
  }

  Future<int> insertProductTax(ProductTax entry) {
    return into(productTaxes).insert(entry);
  }

  Future<int> insertBarcode(ProductBarCodesCompanion entry) {
    return into(productBarCodes).insert(entry);
  }

  Future modify(ProductsCompanion entry) {
    return (update(products)..where((tb) => tb.id.equals(entry.id.value))).write(
      ProductsCompanion(
        name: entry.name,
        price: entry.price,
        cost: entry.cost,
        image: entry.image,
        categoryId: entry.categoryId,
        available: entry.available,
        modifiedAt: entry.modifiedAt,
      ),
    );
  }

  Future modifyVariant(VariantsCompanion entry) {
    return (update(variants)..where((tb) => tb.id.equals(entry.id.value))).write(
      VariantsCompanion(
        productId: entry.productId,
        name: entry.name,
        price: entry.price,
        cost: entry.cost,
        available: entry.available,
        modifiedAt: entry.modifiedAt,
      ),
    );
  }

  Future remove(int id) {
    return (delete(products)..where((tb) => tb.id.equals(id))).go();
  }

  Future removeVariant(int id) {
    return (delete(variants)..where((tb) => tb.id.equals(id))).go();
  }

  Future removeVariantByProduct(int productId) {
    return (delete(variants)..where((tb) => tb.productId.equals(productId))).go();
  }

  Future removeProductDiscount(int productId, {int discountId}) {
    final query = delete(productDiscounts);

    query.where((tb) => tb.productId.equals(productId));

    if ((discountId ?? 0) > 0) {
      query.where((tb) => tb.discountId.equals(discountId));
    }

    return query.go();
  }

  Future removeProductTax(int productId, {int taxId}) {
    final query = delete(productTaxes);

    query.where((tb) => tb.productId.equals(productId));

    if ((taxId ?? 0) > 0) {
      query.where((tb) => tb.taxId.equals(taxId));
    }

    return query.go();
  }

  Future removeBarcode(int productId, {int variantId, bool single = true}) {
    final query = delete(productBarCodes)..where((tb) => tb.productId.equals(productId));

    if (variantId != null) {
      query.where((tb) => tb.variantId.equals(variantId));
    } else if (single) {
      query.where((tb) => isNull(tb.variantId));
    }

    return query.go();
  }

  Future removeBarcodeByCode(String code) {
    return (delete(productBarCodes)..where((tb) => tb.code.equals(code))).go();
  }

  Future<Product> getProduct(int id) {
    return (select(products)..where((tb) => tb.id.equals(id))).getSingle();
  }

  Future<ProductBarCode> getBarcodeByCode(String code) {
    return (select(productBarCodes)..where((tb) => tb.code.equals(code))).getSingle();
  }

  Future<ProductBarCode> getBarcodeBy(int productId, {int variantId}) {
    final query = select(productBarCodes)..where((tb) => tb.productId.equals(productId));

    if (variantId != null) {
      query.where((tb) => tb.variantId.equals(variantId));
    } else {
      query.where((tb) => isNull(tb.variantId));
    }

    query.limit(1);

    return query.getSingle();
  }

  Future<List<Discount>> getDiscountsByProduct(int productId) {
    final query = select(productDiscounts);

    query.where((tb) => tb.productId.equals(productId));

    return query.map((e) => e.discountId).get().then((value) {
      return (select(discounts)..where((tb) => tb.id.isIn(value))).get();
    });
  }

  Future<List<Tax>> getTaxesByProduct(int productId) {
    final query = select(productTaxes);

    query.where((tb) => tb.productId.equals(productId));

    return query.map((e) => e.taxId).get().then((value) {
      return (select(taxes)..where((tb) => tb.id.isIn(value))).get();
    });
  }

  Future<List<VariantWithBarCode>> getVariantsByProduct(int productId) {
    final query = select(variants).join([
      leftOuterJoin(productBarCodes, productBarCodes.variantId.equalsExp(variants.id))
    ]);

    query.where(variants.productId.equals(productId));

    return query.get().then((rows) {
      return rows.map((row) {
        return VariantWithBarCode(
          row.readTable(variants),
          row.readTable(productBarCodes),
        );
      }).toList();
    });
  }

  Future<Variant> getVariant(int id) {
    return (select(variants)..where((tb) => tb.id.equals(id))).getSingle();
  }

  Stream<List<ProductWithCategory>> find(ProductSearch search) {
    final variantCount = variants.id.count(
      filter: search.available != null ? variants.available.equals(search.available) : null,
    );

    final query = _buildSearchQuery(search);

    return query.watch().map((rows) {
      return rows.map((row) {
        final product = row.readTable(products);
        return ProductWithCategory(
          product,
          row.readTable(categories),
          row.read(variantCount),
        );
      }).toList();
    });
  }

  Future<List<ProductWithCategory>> findStatic(ProductSearch search) {
    final variantCount = variants.id.count(
      filter: search.available != null ? variants.available.equals(search.available) : null,
    );

    final query = _buildSearchQuery(search);

    return query.get().then((rows) {
      return rows.map((row) {
        final product = row.readTable(products);
        return ProductWithCategory(
          product,
          row.readTable(categories),
          row.read(variantCount),
        );
      }).toList();
    });
  }

  JoinedSelectStatement<Table, DataClass> _buildSearchQuery(ProductSearch search) {
    final variantCount = variants.id.count(
      filter: search.available != null ? variants.available.equals(search.available) : null,
    );

    final query = select(products).join([
      leftOuterJoin(variants, variants.productId.equalsExp(products.id)),
      leftOuterJoin(categories, categories.id.equalsExp(products.categoryId)),
    ]);

    query
      ..addColumns([variantCount])
      ..groupBy([products.id]);

    if ((search.categoryId ?? 0) > 0) {
      query.where(products.categoryId.equals(search.categoryId));
    }

    if (search.name != null) {
      query.where(products.name.lower().like("${search.name.toLowerCase()}%"));
    }

    if (search.available != null) {
      query.where(products.available.equals(search.available));
    }

    if ((search.limit ?? 0) > 0) {
      query.limit(search.limit, offset: search.offset);
    }

    return query;
  }
}
