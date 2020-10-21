import 'package:pos_domain/pos_domain.dart';

abstract class BuildSaleItemUseCase {
  Future<SaleItemDTO> buildSaleItemById(int productId);

  Future<SaleItemDTO> buildSaleItemByCode(String code);
}

class BuildSaleItemUseCaseImpl implements BuildSaleItemUseCase {
  final ProductRepo _productRepo;
  final VariantRepo _variantRepo;

  BuildSaleItemUseCaseImpl(
    this._productRepo,
    this._variantRepo,
  );

  @override
  Future<SaleItemDTO> buildSaleItemByCode(String code) async {
    final barcode = await _productRepo.getBarcodeByCode(code);
    if (barcode == null) {
      return null;
    }

    if ((barcode.variantId ?? 0) > 0) {
      final variant = await _variantRepo.getVariant(barcode.variantId);
      final product = await _productRepo.getProduct(barcode.productId);

      if (product == null || variant == null) {
        return null;
      }

      if (!product.available || !variant.available) {
        throw("Product not available.");
      }

      final SaleItemDTO item = SaleItemDTO(
        productId: product.id,
        variantId: variant.id,
        price: variant.price,
        cost: variant.cost,
        productName: product.name,
        variantName: variant.name,
      );

      item.discounts = product.discounts ?? [];

      return _calculateDiscountAndTax(item, product);

    }

    return await buildSaleItemById(barcode.productId);
  }

  @override
  Future<SaleItemDTO> buildSaleItemById(int productId) async {
    final product = await _productRepo.getProduct(productId);
    if (product == null) {
      return null;
    }

    if (!product.available) {
      throw("Product not available.");
    }

    final SaleItemDTO item = SaleItemDTO(
      productId: product.id,
      price: product.price,
      cost: product.cost,
      productName: product.name,
    );

    item.discounts = product.discounts ?? [];

    return _calculateDiscountAndTax(item, product);
  }


  SaleItemDTO _calculateDiscountAndTax(SaleItemDTO item, ProductDetailDTO product) {
    item.discount = product.discounts.map((e) {
      if (e.type == DiscountType.percentage) {
        return e.value / 100;
      }
      return ((e.value * 100) / item.price) / 100;
    }).fold(0, (pv, e) => pv + e);

    item.tax = product.taxes.map((e) => e.value / 100).fold(0, (pv, e) => pv + e);

    return item;
  }

}
