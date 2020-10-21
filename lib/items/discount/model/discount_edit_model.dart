import 'package:pos_domain/pos_domain.dart';

class DiscountEditModel {
  final SaveDiscountUseCase saveUseCase;
  final DeleteDiscountUseCase deleteUseCase;

  DiscountEditModel(
    this.saveUseCase,
    this.deleteUseCase,
  );

  Future save(DiscountDTO dto) {
    return saveUseCase.save(dto);
  }

  Future delete(int id) {
    return deleteUseCase.delete(id);
  }
}
