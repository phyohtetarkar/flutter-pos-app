class SaleSearch {
  String code;
  DateTime date;
  int offset;
  int limit;

  SaleSearch({
    this.code,
    this.date,
    this.offset,
    this.limit,
  });

  SaleSearch copyWith({
    String code,
    DateTime date,
    int offset,
    int limit,
  }) {
    return SaleSearch(
      code: code ?? this.code,
      date: date ?? this.date,
      offset: offset ?? this.offset,
      limit: limit ?? this.limit,
    );
  }
}
