import 'package:pos_domain/src/sale/sale_dto.dart';
import 'package:pos_domain/src/sale/sale_repo.dart';
import 'package:pos_domain/src/sale/search/sale_search.dart';

abstract class GetAllSaleUseCase {
  Future<List<SaleDTO>> getAll(SaleSearch search);
}

class GetAllSaleUseCaseImpl implements GetAllSaleUseCase {

  final SaleRepo _repo;

  GetAllSaleUseCaseImpl(this._repo);

  @override
  Future<List<SaleDTO>> getAll(SaleSearch search) {
    return _repo.findStatic(search);
  }

}