import 'package:pos_domain/pos_domain.dart';

class CategoryListModel {
  final GetAllCategoryWithProductCountUseCase getAllUseCase;
  final DeleteCategoryUseCase deleteUseCase;

  CategoryListModel(
    this.getAllUseCase,
    this.deleteUseCase,
  );

  Stream<List<CategoryDTO>> getAll() {
    return getAllUseCase.getAll();
  }

  Future delete(int id) {
    return deleteUseCase.delete(id);
  }
}
