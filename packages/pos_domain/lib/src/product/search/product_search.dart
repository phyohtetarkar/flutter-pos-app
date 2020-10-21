
class ProductSearch {
  String name;
  int categoryId;
  bool available;
  int offset;
  int limit;

  ProductSearch({
    this.name,
    this.categoryId,
    this.available,
    this.offset = 0,
    this.limit,
  });

  ProductSearch copyWith({
    String name,
    int categoryId,
    bool available,
    int offset,
    int limit,
  }) {
    return ProductSearch(
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      available: available ?? this.available,
      offset: offset ?? this.offset,
      limit: limit ?? this.limit,
    );
  }

}
