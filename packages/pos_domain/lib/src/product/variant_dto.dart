class VariantDTO {
  final int id;
  int productId;
  String name;
  double price;
  double cost;
  String barcode;
  bool available;

  bool removed = false;

  VariantDTO({
    this.id,
    this.productId,
    this.name,
    this.price,
    this.cost,
    this.barcode,
    this.available = true,
  });
}
