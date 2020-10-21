import 'package:pos_domain/src/discount/discount_dto.dart';
import 'package:pos_domain/src/discount/discount_repo.dart';

abstract class GetAllDiscountUseCase {
  Stream<List<DiscountDTO>> getAll();
  Future<List<DiscountDTO>> getAllStatic();
}

class GetAllDiscountUseCaseImpl implements GetAllDiscountUseCase {

  final DiscountRepo _repo;

  GetAllDiscountUseCaseImpl(this._repo);

  @override
  Stream<List<DiscountDTO>> getAll() {
    return _repo.findAll();
  }

  @override
  Future<List<DiscountDTO>> getAllStatic() {
    return _repo.findAllStatic();
  }

}