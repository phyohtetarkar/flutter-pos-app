import 'package:pos_domain/src/category/category_dto.dart';
import 'package:pos_domain/src/category/category_repo.dart';

abstract class SaveCategoryUseCase {
  Future save(CategoryDTO dto);
}

class SaveCategoryUseCaseImpl implements SaveCategoryUseCase {
  final CategoryRepo _repo;

  SaveCategoryUseCaseImpl(this._repo);

  @override
  Future save(CategoryDTO dto) {
    return _repo.findByName(dto.name).then((value) {
      if (value != null && value.id != dto.id) {
        return Future.error("Category name already exists.");
      }

      if ((dto.id ?? 0) > 0) {
        return _repo.update(dto);
      }

      return _repo.insert(dto);
    });
  }
}
