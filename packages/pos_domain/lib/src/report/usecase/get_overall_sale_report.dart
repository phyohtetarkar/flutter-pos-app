import 'package:pos_domain/src/report/sale_report_dto.dart';
import 'package:pos_domain/src/sale/sale_repo.dart';

abstract class GetOverallSaleReport {
  Future<SaleReportDTO> getOverallReport();
}

class GetOverallSaleReportImpl implements GetOverallSaleReport {

  final SaleRepo _repo;

  GetOverallSaleReportImpl(this._repo);

  @override
  Future<SaleReportDTO> getOverallReport() {
    return _repo.getOverallSaleReport();
  }

}