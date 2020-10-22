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

  VariantDTO clone() {
    return VariantDTO(
      id: id,
      productId: productId,
      name: name,
      price: price,
      cost: cost,
      barcode: barcode,
      available: available,
    );
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is VariantDTO && runtimeType == other.runtimeType && id == other.id && productId == other.productId && name == other.name && barcode == other.barcode;

  @override
  int get hashCode => id.hashCode ^ productId.hashCode ^ name.hashCode ^ barcode.hashCode;
}
