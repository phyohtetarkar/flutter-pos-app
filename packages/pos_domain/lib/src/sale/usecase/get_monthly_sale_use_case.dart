import 'package:pos_domain/src/sale/sale_repo.dart';

abstract class GetMonthlySaleUseCase {
  Future<Map<int, double>> getMonthlySales(int year);
}

class GetMonthlySaleUseCaseImpl implements GetMonthlySaleUseCase {

  final SaleRepo _repo;

  GetMonthlySaleUseCaseImpl(this._repo);

  @override
  Future<Map<int, double>> getMonthlySales(int year) {
    return _repo.getMonthlySales(year);
  }

}