class SaleReportDTO {
  final double totalPrice;
  final double totalCost;
  final List<SaleByCategoryDTO> list;

  SaleReportDTO({
    this.totalPrice,
    this.totalCost,
    this.list,
  });
}

class SaleByCategoryDTO {
  final double totalPrice;
  final String categoryName;
  final int color;

  SaleByCategoryDTO({
    this.totalPrice,
    this.categoryName,
    this.color,
  });
}
