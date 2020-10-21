import 'package:pos_domain/src/discount/discount_dto.dart';
import 'package:pos_domain/src/discount/discount_repo.dart';

abstract class SaveDiscountUseCase {
  Future save(DiscountDTO dto);
}

class SaveDiscountUseCaseImpl implements SaveDiscountUseCase {

  final DiscountRepo _repo;

  SaveDiscountUseCaseImpl(this._repo);

  @override
  Future save(DiscountDTO dto) {
    return _repo.findByName(dto.name).then((value) {
      if (value != null && value.id != dto.id) {
        return Future.error("Discount name already exists.");
      }

      if ((dto.id ?? 0) > 0) {
        return _repo.update(dto);
      }

      return _repo.insert(dto);
    });
  }

}