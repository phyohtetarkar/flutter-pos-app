import 'package:pos_domain/src/discount/discount_repo.dart';

abstract class DeleteDiscountUseCase {
  Future delete(int id);
}

class DeleteDiscountUseCaseImpl implements DeleteDiscountUseCase {

  final DiscountRepo _repo;

  DeleteDiscountUseCaseImpl(this._repo);

  @override
  Future delete(int id) {
    return _repo.delete(id);
  }

}