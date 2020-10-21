import 'package:pos_domain/pos_domain.dart';

class CategoryEditModel {
  final DeleteCategoryUseCase deleteUseCase;
  final SaveCategoryUseCase saveUseCase;

  CategoryEditModel(
    this.deleteUseCase,
    this.saveUseCase,
  );

  Future save(CategoryDTO dto) {
    return saveUseCase.save(dto);
  }

  Future delete(int id) {
    return deleteUseCase.delete(id);
  }
}
