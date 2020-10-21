import 'package:pos_domain/pos_domain.dart';

abstract class GetAllProductWithCategoryUseCase {
  Stream<List<ProductDTO>> find(ProductSearch search);

  Future<List<ProductDTO>> findStatic(ProductSearch search);
}

class GetAllProductWithCategoryUseCaseImpl implements GetAllProductWithCategoryUseCase {

  final ProductRepo _repo;

  GetAllProductWithCategoryUseCaseImpl(this._repo);

  @override
  Stream<List<ProductDTO>> find(ProductSearch search) {
    return _repo.find(search);
  }

  @override
  Future<List<ProductDTO>> findStatic(ProductSearch search) {
    return _repo.findStatic(search);
  }

}