import 'tax_dto.dart';

abstract class TaxRepo {

  Future<int> insert(TaxDTO dto);

  Future update(TaxDTO dto);

  Future delete(int id);

  Future<TaxDTO> findById(int id);

  Future<TaxDTO> findByName(String name);

  Stream<List<TaxDTO>> findAll();

}
