import 'package:pos_domain/pos_domain.dart';

class TaxEditModel {
  final SaveTaxUseCase saveUseCase;
  final DeleteTaxUseCase deleteUseCase;

  TaxEditModel(
    this.saveUseCase,
    this.deleteUseCase,
  );

  Future save(TaxDTO dto) {
    return saveUseCase.save(dto);
  }

  Future delete(int id) {
    return deleteUseCase.delete(id);
  }
}
