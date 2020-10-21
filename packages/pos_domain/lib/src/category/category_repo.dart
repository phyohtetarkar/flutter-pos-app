import 'category_dto.dart';

abstract class CategoryRepo {

  Future<int> insert(CategoryDTO dto);

  Future update(CategoryDTO dto);

  Future delete(int id);

  Future<CategoryDTO> findById(int id);

  Future<CategoryDTO> findByName(String name);

  Stream<List<CategoryDTO>> findAll();

  Future<List<CategoryDTO>> findAllStatic();

  Stream<List<CategoryDTO>> findAllWithProductCount();

}