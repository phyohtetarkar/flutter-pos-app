import 'package:pos_domain/pos_domain.dart';

abstract class VariantRepo {

  Future<int> insert(VariantDTO dto);

  Future update(VariantDTO dto);

  Future delete(int id);

  Future deleteByProduct(int productId);

  Future<VariantDTO> getVariant(int id);

  Future<List<VariantDTO>> getVariantsByProduct(int productId);

}