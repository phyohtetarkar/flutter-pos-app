import 'package:pos_domain/src/category/category_dto.dart';
import 'package:pos_domain/src/discount/discount_dto.dart';
import 'package:pos_domain/src/product/product_edit_dto.dart';
import 'package:pos_domain/src/product/variant_dto.dart';
import 'package:pos_domain/src/tax/tax_dto.dart';

class ProductDetailDTO {
  final int id;
  final String name;
  final double price;
  final double cost;
  final String image;
  final String barcode;
  final bool available;
  final CategoryDTO category;
  final List<VariantDTO> variants;
  final List<DiscountDTO> discounts;
  final List<TaxDTO> taxes;

  ProductDetailDTO({
    this.id,
    this.name,
    this.price,
    this.cost,
    this.image,
    this.barcode,
    this.available = true,
    this.category,
    this.variants,
    this.discounts,
    this.taxes,
  });

  ProductEditDTO toEdit() {
    return ProductEditDTO(
      id: id,
      name: name,
      price: price,
      cost: cost,
      image: image,
      barcode: barcode,
      available: available,
      categoryId: category.id,
    );
  }

}