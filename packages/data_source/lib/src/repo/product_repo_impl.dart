import 'package:data_source/data_source.dart';
import 'package:data_source/src/dao/category_dao.dart';
import 'package:data_source/src/dao/product_dao.dart';
import 'package:moor/moor.dart';
import 'package:pos_domain/pos_domain.dart';
import 'package:data_source/src/extensions.dart';

class ProductRepoImpl implements ProductRepo {
  final ProductDao _productDao;
  final CategoryDao _categoryDao;

  ProductRepoImpl(this._productDao, this._categoryDao);

  int get millis => DateTime.now().toUtc().millisecondsSinceEpoch;

  @override
  Future<int> insert(ProductEditDTO dto) {
    var issue = millis;
    return _productDao.insert(
      dto.toEntry().copyWith(
            createdAt: Value(issue),
            modifiedAt: Value(issue),
          ),
    );
  }

  @override
  Future<int> insertProductDiscount({int productId, int discountId}) {
    return _productDao.insertProductDiscount(ProductDiscount(productId: productId, discountId: discountId));
  }

  @override
  Future<int> insertProductTax({int productId, int taxId}) {
    return _productDao.insertProductTax(ProductTax(productId: productId, taxId: taxId));
  }

  @override
  Future update(ProductEditDTO dto) {
    return _productDao.modify(
      dto.toEntry().copyWith(
            modifiedAt: Value(millis),
          ),
    );
  }

  @override
  Future delete(int id) {
    return _productDao.remove(id);
  }

  @override
  Future deleteProductDiscount(int productId, {int discountId}) {
    return _productDao.removeProductDiscount(productId, discountId: discountId);
  }

  @override
  Future deleteProductTax(int productId, {int taxId}) {
    return _productDao.removeProductTax(productId, taxId: taxId);
  }

  @override
  Stream<List<ProductDTO>> find(ProductSearch search) {
    return _productDao.find(search).map((list) {
      return list.map((e) => e.toData()).toList();
    });
  }

  @override
  Future<List<ProductDTO>> findStatic(ProductSearch search) {
    return _productDao.findStatic(search).then((list) => list.map((e) => e.toData()).toList());
  }

  @override
  Future<ProductDetailDTO> getProduct(int id) async {
    var product = await _productDao.getProduct(id);
    var barCode = await _productDao.getBarcodeBy(id);
    var category = await _categoryDao.findById(product.categoryId);
    var variants = await _productDao.getVariantsByProduct(id);
    var discounts = await _productDao.getDiscountsByProduct(id);
    var taxes = await _productDao.getTaxesByProduct(id);
    return ProductDetailDTO(
      id: product.id,
      name: product.name,
      price: product.price,
      cost: product.cost,
      image: product.image,
      barcode: barCode?.code,
      available: product.available,
      category: category,
      variants: variants.map((v) => v.toData()).toList(),
      discounts: discounts.map((d) => d.toData()).toList(),
      taxes: taxes.map((t) => t.toData()).toList(),
    );
  }

  @override
  Future<ProductBarCodeDTO> getBarcodeByCode(String barcode) {
    return _productDao.getBarcodeByCode(barcode).then((value) => value?.toData());
  }

  @override
  Future<ProductBarCodeDTO> getBarcodeBy(int productId, {int variantId}) {
    return _productDao.getBarcodeBy(productId, variantId: variantId).then((value) => value?.toData());
  }

  @override
  Future<int> insertBarcode(ProductBarCodeDTO dto) {
    return _productDao.insertBarcode(
      ProductBarCodesCompanion(
        code: Value(dto.code),
        productId: Value(dto.productId),
        variantId: Value(dto.variantId),
      ),
    );
  }

  @override
  Future deleteBarcode(int productId, {int variantId}) {
    return _productDao.removeBarcode(productId, variantId: variantId);
  }

  @override
  Future deleteBarcodeByCode(String code) {
    return _productDao.removeBarcodeByCode(code);
  }

  @override
  Future deleteBarcodeByProduct(int productId) {
    return _productDao.removeBarcode(productId, single: false);
  }


}
