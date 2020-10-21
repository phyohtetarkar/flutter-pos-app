import 'package:data_source/src/dao/tax_dao.dart';
import 'package:moor/moor.dart';
import 'package:pos_domain/pos_domain.dart';
import 'package:data_source/src/extensions.dart';

class TaxRepoImpl implements TaxRepo {

  final TaxDao dao;

  TaxRepoImpl(this.dao);

  int get millis => DateTime.now().toUtc().millisecondsSinceEpoch;

  @override
  Future<int> insert(TaxDTO dto) {
    var issue = millis;
    var entry = dto.toEntry().copyWith(
      createdAt: Value(issue),
      modifiedAt: Value(issue),
    );
    return dao.insert(entry);
  }

  @override
  Future update(TaxDTO dto) {
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
  Stream<List<TaxDTO>> findAll() {
    return dao.findAll();
  }

  @override
  Future<TaxDTO> findById(int id) {
    return dao.findById(id);
  }

  @override
  Future<TaxDTO> findByName(String name) {
    return dao.findByName(name);
  }

}