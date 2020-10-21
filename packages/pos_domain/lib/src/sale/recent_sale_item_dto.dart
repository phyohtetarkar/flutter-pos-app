class RecentSaleItemDTO {
  final int saleId;
  final int saleItemId;
  final int productId;
  final String image;
  final String productName;
  final String variantName;
  final int quantity;
  final double price;
  final double discount;
  final int saleAt;

  double get _total => price * quantity;

  double get totalPrice => _total - (_total * (discount ?? 0));

  DateTime get issueAt => DateTime.fromMillisecondsSinceEpoch(saleAt, isUtc: true).toLocal();

  RecentSaleItemDTO({
    this.saleId,
    this.saleItemId,
    this.productId,
    this.image,
    this.productName,
    this.variantName,
    this.quantity,
    this.price,
    this.discount,
    this.saleAt,
  });
}
