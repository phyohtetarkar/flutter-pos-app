import 'package:pos_domain/pos_domain.dart';

abstract class GetProductByIdUseCase {
  Future<ProductDetailDTO> getProduct(int id);
}

class GetProductByIdUseCaseImpl implements GetProductByIdUseCase {

  final ProductRepo _repo;

  GetProductByIdUseCaseImpl(this._repo);

  @override
  Future<ProductDetailDTO> getProduct(int id) {
    return _repo.getProduct(id);
  }

}