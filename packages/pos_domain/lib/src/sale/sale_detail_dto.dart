import 'package:pos_domain/src/sale/sale_dto.dart';
import 'package:pos_domain/src/sale/sale_item_dto.dart';

class SaleDetailDTO {
  final SaleDTO sale;
  final List<SaleItemDTO> items;

  SaleDetailDTO(
    this.sale,
    this.items,
  );
}
