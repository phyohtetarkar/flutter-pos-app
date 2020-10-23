import 'package:data_source/src/entity/product_entity.dart';
import 'package:data_source/src/entity/sale_entity.dart';
import 'package:data_source/src/entity/sale_item_entity.dart';
import 'package:data_source/src/entity/variant_entity.dart';
import 'package:data_source/src/pos_database.dart';
import 'package:moor/moor.dart';
import 'package:pos_domain/pos_domain.dart';

extension CategoryExtension on CategoryDTO {
  CategoriesCompanion toEntry() {
    return CategoriesCompanion(
      id: id != null ? Value(id) : Value.absent(),
      name: Value(name),
      color: Value(color),
    );
  }
}

extension CategoryEntityExtension on Category {
  CategoryDTO toData() {
    return CategoryDTO(
      id: id,
      name: name,
      color: color,
    );
  }
}

extension DiscountExtension on DiscountDTO {
  DiscountsCompanion toEntry() {
    return DiscountsCompanion(
      id: id != null ? Value(id) : Value.absent(),
      name: Value(name),
      value: Value(value),
      type: Value(type),
    );
  }
}

extension DiscountEntityExtension on Discount {
  DiscountDTO toData() {
    return DiscountDTO(
      id: id,
      name: name,
      value: value,
      type: type,
    );
  }
}

extension TaxExtension on TaxDTO {
  TaxesCompanion toEntry() {
    return TaxesCompanion(
      id: id != null ? Value(id) : Value.absent(),
      name: Value(name),
      value: Value(value),
    );
  }
}

extension TaxEntityExtension on Tax {
  TaxDTO toData() {
    return TaxDTO(
      id: id,
      name: name,
      value: value,
    );
  }
}

extension VarientExtension on VariantDTO {
  VariantsCompanion toEntry() {
    return VariantsCompanion(
      id: id != null ? Value(id) : Value.absent(),
      productId: Value(productId),
      name: Value(name),
      price: Value(price),
      cost: Value(cost),
      available: Value(available),
    );
  }
}

extension VariantEntityExtension on Variant {
  VariantDTO toData() {
    return VariantDTO(
      id: id,
      productId: productId,
      name: name,
      price: price,
      cost: cost,
      available: available,
    );
  }
}

extension VariantWithBarCodeExtension on VariantWithBarCode {
  VariantDTO toData() {
    return VariantDTO(
      id: variant.id,
      productId: variant.productId,
      name: variant.name,
      price: variant.price,
      cost: variant.cost,
      barcode: barCode?.code,
      available: variant.available,
    );
  }
}

extension ProductEditExtension on ProductEditDTO {
  ProductsCompanion toEntry() {
    return ProductsCompanion(
      id: id != null ? Value(id) : Value.absent(),
      name: Value(name),
      price: Value(price),
      cost: Value(cost),
      image: Value(image),
      available: Value(available),
      categoryId: Value(categoryId),
    );
  }
}

extension ProductBarCodeEntityExtension on ProductBarCode {
  ProductBarCodeDTO toData() {
    return ProductBarCodeDTO(
      code: code,
      productId: productId,
      variantId: variantId,
    );
  }
}

extension ProductEntityExtension on ProductWithCategory {
  ProductDTO toData() {
    return ProductDTO(
      id: product.id,
      name: product.name,
      image: product.image,
      price: product.price,
      category: category.name,
      variant: variant,
    );
  }
}

extension SaleWithItemCountExtension on SaleWithItemCount {
  SaleDTO toData() {
    return SaleDTO(
      id: sale.id,
      code: sale.code,
      subTotalPrice: sale.subTotalPrice,
      discount: sale.discount,
      tax: sale.tax,
      totalPrice: sale.totalPrice,
      totalCost: sale.totalCost,
      customerId: sale.customerId,
      payPrice: sale.payPrice,
      change: sale.change,
      totalItem: count,
      createdAt: sale.createdAt,
    );
  }
}

extension SaleExtension on Sale {
  SaleDTO toData() {
    return SaleDTO(
      id: id,
      code: code,
      subTotalPrice: subTotalPrice,
      discount: discount,
      tax: tax,
      totalPrice: totalPrice,
      totalCost: totalCost,
      customerId: customerId,
      payPrice: payPrice,
      change: change,
      createdAt: createdAt,
    );
  }
}

extension SaleItemExtension on SaleItem {
  SaleItemDTO toData() {
    return SaleItemDTO(
      id: id,
      saleId: saleId,
      productId: productId,
      variantId: variantId,
      productName: productName,
      variantName: variantName,
      price: price,
      cost: cost,
      discount: discount,
      tax: tax,
      quantity: quantity,
    );
  }

  double get _total => price * quantity;

  double get totalPrice => _total - (_total * (discount ?? 0));
}

extension SaleDTOExtension on SaleDTO {
  SalesCompanion toEntry() {
    return SalesCompanion(
      id: id != null ? Value(id) : Value.absent(),
      customerId: Value(customerId),
      code: Value(code),
      subTotalPrice: Value(subTotalPrice),
      totalPrice: Value(totalPrice),
      totalCost: Value(totalCost),
      discount: Value(discount),
      tax: Value(tax),
      payPrice: Value(payPrice),
      change: Value(change),
    );
  }
}

extension SaleItemDTOExtension on SaleItemDTO {
  SaleItemsCompanion toEntry() {
    return SaleItemsCompanion(
      id: id != null ? Value(id) : Value.absent(),
      saleId: Value(saleId),
      productId: Value(productId),
      variantId: Value(variantId),
      productName: Value(productName),
      variantName: Value(variantName),
      price: Value(price),
      cost: Value(cost),
      quantity: Value(quantity),
      totalPrice: Value(totalPrice),
      discount: Value(discount),
      tax: Value(tax),
    );
  }
}

extension SaleItemWithProductExtension on SaleItemWithProduct {
  RecentSaleItemDTO toData() {
    return RecentSaleItemDTO(
      productName: product?.name ?? item.productName,
      variantName: variant?.name ?? item.variantName,
      image: product?.image,
      price: item.price,
    );
  }
}

extension DistinctSaleItemExtension on DistinctSaleItem {
  RecentSaleItemDTO toData() {
    return RecentSaleItemDTO(
      productName: product,
      variantName: variant,
      image: image,
      price: price,
      quantity: quantity,
    );
  }
}