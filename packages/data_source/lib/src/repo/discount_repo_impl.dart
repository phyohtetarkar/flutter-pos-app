import 'package:data_source/src/dao/discount_dao.dart';
import 'package:moor/moor.dart';
import 'package:pos_domain/pos_domain.dart';
import 'package:data_source/src/extensions.dart';

class DiscountRepoImpl implements DiscountRepo {

  final DiscountDao dao;

  DiscountRepoImpl(this.dao);

  int get millis => DateTime.now().toUtc().millisecondsSinceEpoch;

  @override
  Future<int> insert(DiscountDTO dto) {
    var issue = millis;
    var entry = dto.toEntry().copyWith(
      createdAt: Value(issue),
      modifiedAt: Value(issue),
    );
    return dao.insert(entry);
  }

  @override
  Future update(DiscountDTO dto) {
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
  Stream<List<DiscountDTO>> findAll() {
    return dao.findAll();
  }

  @override
  Future<DiscountDTO> findById(int id) {
    return dao.findById(id);
  }

  @override
  Future<DiscountDTO> findByName(String name) {
    return dao.findByName(name);
  }

  @override
  Future<List<DiscountDTO>> findAllStatic() {
    return dao.findAllStatic();
  }

}