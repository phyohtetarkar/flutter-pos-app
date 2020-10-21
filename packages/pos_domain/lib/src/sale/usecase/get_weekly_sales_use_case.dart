import 'package:pos_domain/src/sale/sale_repo.dart';

abstract class GetWeeklySalesUseCase {
  Future<Map<int, double>> getWeeklySales();
}

class GetWeeklySalesUseCaseImpl implements GetWeeklySalesUseCase {

  final SaleRepo _repo;

  GetWeeklySalesUseCaseImpl(this._repo);

  @override
  Future<Map<int, double>> getWeeklySales() {
    var dt = DateTime.now();

    dt = DateTime(dt.year, dt.month, dt.day);

    //print(dt.toIso8601String());
    //print("Week Day: ${dt.weekday}");

    int dayToMinus = (dt.weekday - 7) + 6;
    int dayToPlus = 7 - dt.weekday;

    final start = dt.subtract(Duration(days: dayToMinus));
    final end = dt.add(Duration(days: dayToPlus));

    //print("Start: ${start.toIso8601String()}");
    //print("End: ${end.toIso8601String()}");

    var from = DateTime(start.year, start.month, start.day).toUtc().millisecondsSinceEpoch;
    var to = DateTime(end.year, end.month, end.day, 23, 59, 59).toUtc().millisecondsSinceEpoch;
    return _repo.getWeeklySales(from, to);
  }

}