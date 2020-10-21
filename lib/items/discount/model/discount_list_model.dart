import 'package:pos_domain/pos_domain.dart';

class DiscountListModel {
  final GetAllDiscountUseCase getAllUseCase;
  final DeleteDiscountUseCase deleteUseCase;

  DiscountListModel(
    this.getAllUseCase,
    this.deleteUseCase,
  );

  Stream<List<DiscountDTO>> getAll() {
    return getAllUseCase.getAll();
  }

  Future delete(int id) {
    return deleteUseCase.delete(id);
  }

}
