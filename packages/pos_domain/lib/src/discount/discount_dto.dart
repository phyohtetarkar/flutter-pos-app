enum DiscountType { percentage, absolute }

extension DiscountTypeExtension on DiscountType {
  String get name {
    switch (this) {
      case DiscountType.percentage:
        return "%";
      case DiscountType.absolute:
        return "";
      default:
        return "";
    }
  }
}

class DiscountDTO {
  final int id;
  final String name;
  final double value;
  final DiscountType type;

  DiscountDTO({
    this.id,
    this.name,
    this.value,
    this.type,
  });

}
