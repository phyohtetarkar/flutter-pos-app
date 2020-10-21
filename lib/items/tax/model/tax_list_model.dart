import 'package:pos_domain/pos_domain.dart';

class TaxListModel {
  final GetAllTaxUseCase getAllUseCase;
  final DeleteTaxUseCase deleteUseCase;

  TaxListModel(
    this.getAllUseCase,
    this.deleteUseCase,
  );

  Stream<List<TaxDTO>> getAll() {
    return getAllUseCase.getAll();
  }

  Future delete(int id) {
    return deleteUseCase.delete(id);
  }
  
}
