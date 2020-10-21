import 'dart:io';

class ProductEditDTO {
  final int id;
  String name;
  double price;
  double cost;
  String image;
  String barcode;
  bool available;
  int categoryId;

  File imageFile;

  ProductEditDTO({
    this.id,
    this.name,
    this.price,
    this.cost,
    this.image,
    this.barcode,
    this.available = true,
    this.categoryId,
  });
}
