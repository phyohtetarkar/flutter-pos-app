import 'package:pos_domain/src/sale/sale_dto.dart';
import 'package:pos_domain/src/sale/sale_item_dto.dart';
import 'package:pos_domain/src/sale/sale_repo.dart';

abstract class CreateSaleUseCase {
  Future<int> create(SaleDTO sale, List<SaleItemDTO> items);
}

class CreateSaleUseCaseImpl implements CreateSaleUseCase {

  final SaleRepo _repo;

  CreateSaleUseCaseImpl(this._repo);

  @override
  Future<int> create(SaleDTO sale, List<SaleItemDTO> items) async {
    int saleId = await _repo.insertSale(sale);
    await _repo.insertSaleCode(saleId, "${10000 + saleId}");
    for (var item in items) {
      item.saleId = saleId;
      if (!item.removed) {
        await _repo.insertSaleItem(item);
      } else if (item.id > 0) {
        await _repo.removeSaleItem(item.id);
      }
    }
    return saleId;
  }

}