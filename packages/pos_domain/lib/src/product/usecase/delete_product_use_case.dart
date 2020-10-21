import 'package:pos_domain/pos_domain.dart';

abstract class DeleteProductUseCase {
  Future delete(int id);
}

class DeleteProductUseCaseImpl implements DeleteProductUseCase {

  final ProductRepo _productRepo;
  final VariantRepo _variantRepo;

  DeleteProductUseCaseImpl(this._productRepo, this._variantRepo);

  @override
  Future delete(int id) async {
    await _productRepo.deleteProductDiscount(id);
    await _productRepo.deleteProductTax(id);
    await _productRepo.deleteBarcodeByProduct(id);
    await _variantRepo.deleteByProduct(id);
    await _productRepo.delete(id);
  }

}