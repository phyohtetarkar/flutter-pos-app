import 'discount_dto.dart';

abstract class DiscountRepo {

  Future<int> insert(DiscountDTO dto);

  Future update(DiscountDTO dto);

  Future delete(int id);

  Future<DiscountDTO> findById(int id);

  Future<DiscountDTO> findByName(String name);

  Stream<List<DiscountDTO>> findAll();

  Future<List<DiscountDTO>> findAllStatic();

}