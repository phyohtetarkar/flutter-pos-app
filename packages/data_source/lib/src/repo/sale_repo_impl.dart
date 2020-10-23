import 'package:data_source/src/dao/sale_dao.dart';
import 'package:moor/moor.dart';
import 'package:pos_domain/pos_domain.dart';
import 'package:data_source/src/extensions.dart';

class SaleRepoImpl implements SaleRepo {

  final SaleDao _dao;

  SaleRepoImpl(this._dao);

  int get millis => DateTime.now().toUtc().millisecondsSinceEpoch;

  @override
  Future<int> insertSale(SaleDTO sale) {
    final issue = millis;
    final date = DateTime.now();
    return _dao.insertSale(
      sale.toEntry().copyWith(
        createdAt: Value(issue),
        modifiedAt: Value(issue),
        year: Value(date.year),
        month: Value(date.month),
      ),
    );
  }

  @override
  Future<int> insertSaleItem(SaleItemDTO item) {
    final issue = millis;
    return _dao.insertSaleItem(
      item.toEntry().copyWith(
        createdAt: Value(issue),
        modifiedAt: Value(issue),
      ),
    );
  }

  @override
  Future removeSale(int id) {
    return _dao.removeSale(id);
  }

  @override
  Future removeSaleItem(int id) {
    return _dao.removeSaleItem(id);
  }

  @override
  Future<List<SaleDTO>> findStatic(SaleSearch search) {
    return _dao.findStatic(search).then((list) => list.map((e) => e.toData()).toList());
  }

  @override
  Future<List<SaleItemDTO>> getSaleItems(int saleId) {
    return _dao.getSaleItems(saleId).then((list) => list.map((e) => e.toData()).toList());
  }

  @override
  Future<SaleDetailDTO> getSaleDetail(int saleId) async {
    final sale = await _dao.getSale(saleId);
    final items = await _dao.getSaleItems(saleId);
    return SaleDetailDTO(
      sale.toData(),
      items.map((e) => e.toData()).toList(),
    );
  }

  @override
  Future insertSaleCode(int saleId, String code) {
    return _dao.insertSaleCode(saleId, code);
  }

  @override
  Future<List<RecentSaleItemDTO>> getRecentSaleItems({DateTime dateTime}) {
    return _dao.getDistinctSaleItems(dateTime: dateTime).then((list) => list.map((e) => e.toData()).toList());
  }

  @override
  Future<Map<int, double>> getMonthlySales(int year) {
    return _dao.getMonthlySales(year).then((list) {
      return Map.fromIterable(list, key: (e) => e.month, value: (e) => e.amount);
    });
  }

  @override
  Future<Map<int, double>> getWeeklySales(int start, int end) {
    return _dao.getWeeklySales(from: start, to: end).then((list) {
      final Map<int, double> result = {};

      for (var s in list) {
        final weekDay = DateTime.fromMillisecondsSinceEpoch(s.createdAt, isUtc: true).toLocal().weekday;

        final old = result[weekDay] ?? 0;

        result[weekDay] = s.totalPrice + old;
      }

      return result;
    });
  }

}