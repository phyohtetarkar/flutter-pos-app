import 'package:pos_domain/src/category/category_dto.dart';
import 'package:pos_domain/src/category/category_repo.dart';

abstract class GetAllCategoryWithProductCountUseCase {
  Stream<List<CategoryDTO>> getAll();
}

class GetAllCategoryWithProductCountUseCaseImpl implements GetAllCategoryWithProductCountUseCase {

  final CategoryRepo _repo;

  GetAllCategoryWithProductCountUseCaseImpl(this._repo);

  @override
  Stream<List<CategoryDTO>> getAll() {
    return _repo.findAllWithProductCount();
  }

}