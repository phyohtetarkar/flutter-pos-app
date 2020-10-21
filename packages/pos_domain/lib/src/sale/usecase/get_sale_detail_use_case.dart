import 'package:pos_domain/pos_domain.dart';

abstract class GetSaleDetailUseCase {
  Future<SaleDetailDTO> getSaleDetail(int saleId);
}

class GetSaleDetailUseCaseImpl implements GetSaleDetailUseCase {

  final SaleRepo _repo;

  GetSaleDetailUseCaseImpl(this._repo);

  @override
  Future<SaleDetailDTO> getSaleDetail(int saleId) {
    return _repo.getSaleDetail(saleId);
  }

}