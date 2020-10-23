import 'package:pos_domain/src/sale/recent_sale_item_dto.dart';
import 'package:pos_domain/src/sale/sale_repo.dart';

abstract class GetRecentSaleItemUseCase {
  Future<List<RecentSaleItemDTO>> getRecentSaleItems({DateTime dateTime});
}

class GetRecentSaleItemUseCaseImpl implements GetRecentSaleItemUseCase {

  final SaleRepo _repo;

  GetRecentSaleItemUseCaseImpl(this._repo);

  @override
  Future<List<RecentSaleItemDTO>> getRecentSaleItems({DateTime dateTime}) {
    return _repo.getRecentSaleItems(dateTime: dateTime);
  }

}