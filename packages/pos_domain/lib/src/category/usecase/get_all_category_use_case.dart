import 'package:pos_domain/src/category/category_dto.dart';
import 'package:pos_domain/src/category/category_repo.dart';

abstract class GetAllCategoryUseCase {
  Stream<List<CategoryDTO>> getAll();

  Future<List<CategoryDTO>> findAllStatic();
}

class GetAllCategoryUseCaseImpl implements GetAllCategoryUseCase {

  final CategoryRepo _repo;

  GetAllCategoryUseCaseImpl(this._repo);

  @override
  Stream<List<CategoryDTO>> getAll() {
    return _repo.findAll();
  }

  @override
  Future<List<CategoryDTO>> findAllStatic() {
    return _repo.findAllStatic();
  }

}