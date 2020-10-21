import 'package:intl/intl.dart';
import 'package:latte_pos/common/localizations.dart';
import 'package:latte_pos/main.dart';

extension DoubleExtension on double {

  String format() {
    if (truncateToDouble() == this) {
      return toInt().toString();
    }
    return toString();
  }

  String formatCurrency() {
    var f = NumberFormat("#,###.##", "en_US");
    return f.format(this);
  }

  String formatCompactCurrency() {
    var f = NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: '',
    );

    final numStr = round().toString();
    if (numStr.length > 2) {
      final reduce = "${numStr.substring(0, 2)}${List.generate(numStr.length - 2, (i) => "0").join()}";
      final value = double.tryParse(reduce) ?? 500;
      return f.format(value);
    }

    return f.format(this);
  }

}

extension IntegerExtension on int {

  String formatCurrency() {
    var f = NumberFormat("#,###", "en_US");
    return f.format(this);
  }

  String formatCompactCurrency() {
    var f = NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: '',
    );
    return f.format(this);
  }

}

extension StringExtension on String {

  String localize() {
    if (appLocale == AppLocale.MM) {
      return myanmarLocale[this] ?? this;
    }
    return englishLocale[this] ?? this;
  }

}