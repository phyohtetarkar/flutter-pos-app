class SaleSearch {
  String code;
  int offset;
  int limit;

  SaleSearch({
    this.code,
    this.offset,
    this.limit,
  });

  SaleSearch copyWith({
    String code,
    int offset,
    int limit,
  }) {
    return SaleSearch(
      code: code ?? this.code,
      offset: offset ?? this.offset,
      limit: limit ?? this.limit,
    );
  }
}
