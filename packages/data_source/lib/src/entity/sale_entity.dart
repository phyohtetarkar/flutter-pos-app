import 'package:data_source/data_source.dart';
import 'package:moor/moor.dart';

class Sales extends Table with Auditor {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get customerId => integer().nullable()();

  TextColumn get code => text()();

  RealColumn get subTotalPrice => real()();

  RealColumn get totalPrice => real()();

  RealColumn get totalCost => real().nullable()();

  RealColumn get discount => real().nullable()();

  RealColumn get tax => real().nullable()();

  RealColumn get payPrice => real().nullable()();

  RealColumn get change => real().nullable()();

  IntColumn get year => integer()();

  IntColumn get month => integer()();
}

class SaleWithItemCount {
  final Sale sale;
  final int count;

  SaleWithItemCount(
    this.sale,
    this.count,
  );
}

class TotalSaleBalance {
  final double totalPrice;
  final double totalCost;

  TotalSaleBalance({
    this.totalPrice,
    this.totalCost,
  });
}

class MonthlySale {
  final int month;
  final double amount;

  MonthlySale(
    this.month,
    this.amount,
  );
}

class WeeklySale {
  final int saleAt;
  final double amount;

  DateTime get issueAt => DateTime.fromMillisecondsSinceEpoch(saleAt, isUtc: true).toLocal();

  WeeklySale(
    this.saleAt,
    this.amount,
  );
}
