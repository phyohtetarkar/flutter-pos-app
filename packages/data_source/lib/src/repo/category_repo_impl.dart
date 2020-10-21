import 'package:data_source/src/dao/category_dao.dart';
import 'package:moor/moor.dart';
import 'package:pos_domain/pos_domain.dart';
import 'package:data_source/src/extensions.dart';

class CategoryRepoImpl implements CategoryRepo {

  final CategoryDao dao;

  CategoryRepoImpl(this.dao);

  int get millis => DateTime.now().toUtc().millisecondsSinceEpoch;

  @override
  Future<int> insert(CategoryDTO dto) {
    var issue = millis;
    var entry = dto.toEntry().copyWith(
      createdAt: Value(issue),
      modifiedAt: Value(issue),
    );
    return dao.insert(entry);
  }

  @override
  Future update(CategoryDTO dto) {
    var entry = dto.toEntry().copyWith(
      modifiedAt: Value(millis),
    );
    return dao.modify(entry);
  }

  @override
  Future delete(int id) {
    return dao.remove(id);
  }

  @override
  Stream<List<CategoryDTO>> findAll() {
    return dao.findAll();
  }

  @override
  Future<CategoryDTO> findById(int id) {
    return dao.findById(id);
  }

  @override
  Future<CategoryDTO> findByName(String name) {
    return dao.findByName(name);
  }

  @override
  Stream<List<CategoryDTO>> findAllWithProductCount() {
    return dao.findAllWithProductCount().map((list) {
      return list.map((e) {
        return CategoryDTO(
          id: e.category.id,
          name: e.category.name,
          color: e.category.color,
          product: e.count,
        );
      }).toList();
    });
  }

  @override
  Future<List<CategoryDTO>> findAllStatic() {
    return dao.findAllStatic();
  }

}