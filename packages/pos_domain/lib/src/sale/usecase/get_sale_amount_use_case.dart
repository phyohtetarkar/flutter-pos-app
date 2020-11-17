import 'package:pos_domain/src/sale/sale_repo.dart';
import 'package:pos_domain/src/sale/search/sale_search.dart';

abstract class GetSaleAmountUseCase {
  Future<double> getSaleAmount(SaleSearch search);
}

class GetSaleAmountUseCaseImpl implements GetSaleAmountUseCase {

  final SaleRepo _repo;

  GetSaleAmountUseCaseImpl(this._repo);

  @override
  Future<double> getSaleAmount(SaleSearch search) {
    return _repo.findSaleAmount(search);
  }

}