class RecentSaleItemDTO {
  final String image;
  final String productName;
  final String variantName;
  final int quantity;
  final double price;

  RecentSaleItemDTO({
    this.image,
    this.productName,
    this.variantName,
    this.quantity = 0,
    this.price = 0,
  });
}
