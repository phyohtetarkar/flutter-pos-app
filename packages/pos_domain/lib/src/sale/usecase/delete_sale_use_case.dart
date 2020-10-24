import 'package:pos_domain/src/sale/sale_repo.dart';

abstract class DeleteSaleUseCase {
  Future delete(int saleId);
}

class DeleteSaleUseCaseImpl implements DeleteSaleUseCase {

  final SaleRepo _repo;

  DeleteSaleUseCaseImpl(this._repo);

  @override
  Future delete(int saleId) async {
    await _repo.removeSaleItemsBySale(saleId);
    await _repo.removeSale(saleId);
  }

}
