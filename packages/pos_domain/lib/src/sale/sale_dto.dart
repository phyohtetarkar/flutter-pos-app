class SaleDTO {
  final int id;
  int customerId;
  String code;
  double subTotalPrice;
  double totalPrice;
  double totalCost;
  double discount;
  double tax;
  double payPrice;
  double change;
  int totalItem;
  int createdAt;

  DateTime get issueAt => DateTime.fromMillisecondsSinceEpoch(createdAt, isUtc: true).toLocal();

  SaleDTO({
    this.id,
    this.customerId,
    this.code = "",
    this.subTotalPrice,
    this.totalPrice,
    this.totalCost,
    this.discount,
    this.tax,
    this.payPrice,
    this.change,
    this.totalItem,
    this.createdAt,
  });
}
