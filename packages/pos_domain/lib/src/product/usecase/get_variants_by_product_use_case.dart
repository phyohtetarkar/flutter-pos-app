import 'package:pos_domain/pos_domain.dart';

abstract class GetVariantsByProductUseCase {
  Future<List<VariantDTO>> getVariantsByProduct(int productId);
}

class GetVariantsByProductUseCaseImpl implements GetVariantsByProductUseCase {

  final VariantRepo _repo;

  GetVariantsByProductUseCaseImpl(this._repo);

  @override
  Future<List<VariantDTO>> getVariantsByProduct(int productId) {
    return _repo.getVariantsByProduct(productId);
  }

}