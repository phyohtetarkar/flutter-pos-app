import 'package:pos_domain/src/tax/tax_dto.dart';
import 'package:pos_domain/src/tax/tax_repo.dart';

abstract class GetAllTaxUseCase {
  Stream<List<TaxDTO>> getAll();
}

class GetAllTaxUseCaseImpl implements GetAllTaxUseCase {

  final TaxRepo _repo;

  GetAllTaxUseCaseImpl(this._repo);

  @override
  Stream<List<TaxDTO>> getAll() {
    return _repo.findAll();
  }

}