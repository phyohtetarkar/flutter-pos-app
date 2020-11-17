
import 'package:pos_domain/src/report/sale_report_dto.dart';

import 'recent_sale_item_dto.dart';
import 'sale_detail_dto.dart';
import 'sale_dto.dart';
import 'sale_item_dto.dart';
import 'search/sale_search.dart';

abstract class SaleRepo {

  Future<int> insertSale(SaleDTO sale);

  Future<int> insertSaleItem(SaleItemDTO item);

  Future insertSaleCode(int saleId, String code);

  Future removeSale(int id);

  Future removeSaleItem(int id);

  Future removeSaleItemsBySale(int saleId);

  Future<SaleDetailDTO> getSaleDetail(int saleId);

  Future<List<SaleItemDTO>> getSaleItems(int saleId);

  Future<List<SaleDTO>> findStatic(SaleSearch search);

  Future<double> findSaleAmount(SaleSearch search);

  Future<List<RecentSaleItemDTO>> getRecentSaleItems({DateTime dateTime});

  Future<Map<int, double>> getMonthlySales(int year);

  Future<Map<int, double>> getWeeklySales(int start, int end);

  Future<SaleReportDTO> getOverallSaleReport();

}