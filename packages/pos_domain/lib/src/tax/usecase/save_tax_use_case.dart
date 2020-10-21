import 'package:pos_domain/src/tax/tax_dto.dart';
import 'package:pos_domain/src/tax/tax_repo.dart';

abstract class SaveTaxUseCase {
  Future save(TaxDTO dto);
}

class SaveTaxUseCaseImpl implements SaveTaxUseCase {

  final TaxRepo _repo;

  SaveTaxUseCaseImpl(this._repo);

  @override
  Future save(TaxDTO dto) {
    return _repo.findByName(dto.name).then((value) {
      if (value != null && value.id != dto.id) {
        return Future.error("Tax name already exists.");
      }

      if ((dto.id ?? 0) > 0) {
        return _repo.update(dto);
      }

      return _repo.insert(dto);
    });
  }

}