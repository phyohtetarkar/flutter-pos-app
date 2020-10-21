import 'package:pos_domain/src/tax/tax_repo.dart';

abstract class DeleteTaxUseCase {
  Future delete(int id);
}

class DeleteTaxUseCaseImpl implements DeleteTaxUseCase {

  final TaxRepo _repo;

  DeleteTaxUseCaseImpl(this._repo);

  @override
  Future delete(int id) {
    return _repo.delete(id);
  }

}
