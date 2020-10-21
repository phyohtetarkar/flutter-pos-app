import 'package:data_source/src/dao/product_dao.dart';
import 'package:moor/moor.dart';
import 'package:pos_domain/pos_domain.dart';
import 'package:data_source/src/extensions.dart';

class VariantRepoImpl implements VariantRepo {
  final ProductDao _dao;

  VariantRepoImpl(this._dao);

  int get millis => DateTime.now().toUtc().millisecondsSinceEpoch;

  @override
  Future<int> insert(VariantDTO dto) {
    var issue = millis;
    return _dao.insertVariant(
      dto.toEntry().copyWith(
        createdAt: Value(issue),
        modifiedAt: Value(issue),
      ),
    );
  }

  @override
  Future update(VariantDTO dto) {
    return _dao.modifyVariant(
      dto.toEntry().copyWith(
        modifiedAt: Value(millis),
      ),
    );
  }

  @override
  Future delete(int id) {
    return _dao.removeVariant(id);
  }

  @override
  Future deleteByProduct(int productId) {
    return _dao.removeVariantByProduct(productId);
  }

  @override
  Future<List<VariantDTO>> getVariantsByProduct(int productId) {
    return _dao.getVariantsByProduct(productId).then((list) {
      return list.map((v) => v.toData()).toList();
    });
  }

  @override
  Future<VariantDTO> getVariant(int id) {
    return _dao.getVariant(id).then((e) => e.toData());
  }
}
