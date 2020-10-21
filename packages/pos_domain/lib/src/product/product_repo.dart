import 'package:pos_domain/pos_domain.dart';

abstract class ProductRepo {

  Future<int> insert(ProductEditDTO dto);

  Future<int> insertProductDiscount({int productId, int discountId});

  Future<int> insertProductTax({int productId, int taxId});

  Future<int> insertBarcode(ProductBarCodeDTO dto);

  Future update(ProductEditDTO dto);

  Future delete(int id);

  Future deleteProductDiscount(int productId, {int discountId});

  Future deleteProductTax(int productId, {int taxId});

  Future deleteBarcodeByCode(String code);

  Future deleteBarcode(int productId, {int variantId});

  Future deleteBarcodeByProduct(int productId);

  Future<ProductDetailDTO> getProduct(int id);

  Stream<List<ProductDTO>> find(ProductSearch search);

  Future<List<ProductDTO>> findStatic(ProductSearch search);

  Future<ProductBarCodeDTO> getBarcodeByCode(String barcode);

  Future<ProductBarCodeDTO> getBarcodeBy(int productId, {int variantId});

}