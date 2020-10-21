import 'package:pos_domain/pos_domain.dart';

class AllCategoryModel {
  final GetAllCategoryUseCase _useCase;

  AllCategoryModel(this._useCase);

  Stream<List<CategoryDTO>> getAll() {
    return _useCase.getAll();
  }

  Future<List<CategoryDTO>> getAllStatic() {
    return _useCase.findAllStatic();
  }

}