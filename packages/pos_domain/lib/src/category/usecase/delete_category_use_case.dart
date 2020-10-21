import 'package:pos_domain/src/category/category_repo.dart';

abstract class DeleteCategoryUseCase {
  Future delete(int id);
}

class DeleteCategoryUseCaseImpl implements DeleteCategoryUseCase {
  final CategoryRepo _repo;

  DeleteCategoryUseCaseImpl(this._repo);

  @override
  Future delete(int id) {
    return _repo.delete(id);
  }

}