import 'package:pos_domain/pos_domain.dart';

abstract class SaveProductUseCase {
  Future save(ProductEditDTO dto, {List<VariantDTO> variants, List<int> discounts, List<int> taxes});
}

class SaveProductUseCaseImpl implements SaveProductUseCase {

  final ProductRepo _productRepo;
  final VariantRepo _variantRepo;

  SaveProductUseCaseImpl(this._productRepo, this._variantRepo);

  @override
  Future save(ProductEditDTO dto, {List<VariantDTO> variants, List<int> discounts, List<int> taxes}) async {
    int id = dto.id;

    for (VariantDTO v in variants?.where((e) => e.removed) ?? []) {
      await _productRepo.deleteBarcode(v.productId, variantId: v.id);
      await _variantRepo.delete(v.id);
    }

    if (dto.barcode?.isNotEmpty ?? false) {
      final barcode = await _productRepo.getBarcodeByCode(dto.barcode);

      if (barcode != null && barcode.productId != dto.id) {
        return Future.error("Barcode duplicated.");
      }
    }

    if (id != null) {
      await _productRepo.update(dto);
    } else {
      id = await _productRepo.insert(dto);
    }

    await _productRepo.deleteBarcode(id);

    if (dto.barcode?.isNotEmpty ?? false) {
      await _productRepo.insertBarcode(
        ProductBarCodeDTO(
          code: dto.barcode,
          productId: id,
        ),
      );
    }

    for (VariantDTO v in variants?.where((e) => !e.removed) ?? []) {
      v.productId = id;
      if (v.id != null) {
        await _variantRepo.update(v);
        await _productRepo.deleteBarcode(id, variantId: v.id);
        await _insertVariantCode(code: v.barcode, productId: v.productId, variantId: v.id);
      } else {
        final variantId = await _variantRepo.insert(v);
        await _insertVariantCode(code: v.barcode, productId: v.productId, variantId: variantId);
      }
    }

    await _productRepo.deleteProductDiscount(id);
    for (int discountId in discounts ?? []) {
      await _productRepo.insertProductDiscount(productId: id, discountId: discountId);
    }

    await _productRepo.deleteProductTax(id);
    for (int taxId in taxes ?? []) {
      await _productRepo.insertProductTax(productId: id, taxId: taxId);
    }
  }

  Future<int> _insertVariantCode({String code, int productId, int variantId}) {
    if (code?.isEmpty ?? true) {
      return Future.value();
    }

    return _productRepo.insertBarcode(
      ProductBarCodeDTO(
        code: code,
        productId: productId,
        variantId: variantId,
      ),
    );
  }

}