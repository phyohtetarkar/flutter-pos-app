import 'package:pos_domain/pos_domain.dart';

class SaleItemDTO {
  final int id;
  int productId;
  int variantId;
  int saleId;
  String productName;
  String variantName;
  double price;
  double cost;
  int quantity;
  double discount;
  double tax;

  bool removed = false;

  List<DiscountDTO> discounts;

  double get total => price * quantity;

  double get computedSingleDiscount => discount * price;

  double get computedDiscount => discount * total;

  double get computedTax => tax * (total - computedDiscount);

  SaleItemDTO({
    this.id,
    this.productId,
    this.variantId,
    this.saleId,
    this.productName,
    this.variantName,
    this.price = 0,
    this.cost,
    this.quantity = 1,
    this.discount = 0,
    this.tax = 0,
  });
}
