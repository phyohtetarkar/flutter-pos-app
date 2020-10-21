import 'package:pos_domain/src/sale/recent_sale_item_dto.dart';
import 'package:pos_domain/src/sale/sale_repo.dart';

abstract class GetRecentSaleItemUseCase {
  Future<List<RecentSaleItemDTO>> getRecentSaleItems();
}

class GetRecentSaleItemUseCaseImpl implements GetRecentSaleItemUseCase {

  final SaleRepo _repo;

  GetRecentSaleItemUseCaseImpl(this._repo);

  @override
  Future<List<RecentSaleItemDTO>> getRecentSaleItems() {
    return _repo.getRecentSaleItems(10);
  }

}