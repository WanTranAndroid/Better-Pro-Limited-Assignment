import 'package:better_pro_assignment/core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'currency.dart';

part 'amount.freezed.dart';

@freezed
class Amount with _$Amount {
  const Amount._(); // Added to allow custom methods/constructors

  const factory Amount({
    required BigInt value,
    required int precision,
    required Currency currency,
  }) = _Amount;

  factory Amount.fromString(String amountStr, {Currency currency = Currency.USD, int precision = MockConfig.defaultPrecision}) {
    if (amountStr.isEmpty) {
      return Amount(value: BigInt.zero, precision: precision, currency: currency);
    }

    // Simple parsing logic: "10.50" -> 1050 (for precision 2)
    // Remove non-numeric except dot
    final clean = amountStr.replaceAll(RegExp(r'[^0-9.]'), '');
    final parts = clean.split('.');

    if (parts.length > 2) throw const FormatException('Invalid amount format');

    String integerPart = parts[0];
    if (integerPart.isEmpty) integerPart = '0';
    
    String fractionalPart = parts.length > 1 ? parts[1] : '';

    // Pad or truncate fractional part to match precision
    if (fractionalPart.length > precision) {
      fractionalPart = fractionalPart.substring(0, precision);
    } else {
      while (fractionalPart.length < precision) {
        fractionalPart += '0';
      }
    }

    final parsedValue = BigInt.parse('$integerPart$fractionalPart');
    
    return Amount(value: parsedValue, precision: precision, currency: currency);
  }
  
  // Helper to format back to string
  String get formatted {
    final str = value.toString();
    if (precision == 0) return str;
    
    // Pad left with zeros if value is small (e.g. 5 -> 0.05)
    final minLength = precision + 1;
    final paddedStr = str.padLeft(minLength, '0');
    
    final intIndex = paddedStr.length - precision;
    return '${paddedStr.substring(0, intIndex)}.${paddedStr.substring(intIndex)}';
  }
}
