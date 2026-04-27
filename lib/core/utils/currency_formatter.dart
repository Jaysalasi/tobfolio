/// Utility functions for formatting currency values
class CurrencyFormatter {
  /// Maps currency codes to their symbols
  static const Map<String, String> _currencySymbols = {
    'USD': '\$',
    'NGN': '₦',
    'EUR': '€',
    'GBP': '£',
    'JPY': '¥',
    'CNY': '¥',
    'CAD': 'C\$',
    'AUD': 'A\$',
    'CHF': 'CHF',
    'INR': '₹',
    'ZAR': 'R',
    'KES': 'KSh',
    'GHS': '₵',
    'BRL': 'R\$',
    'MXN': 'MX\$',
    'RUB': '₽',
    'KRW': '₩',
    'SGD': 'S\$',
    'HKD': 'HK\$',
    'NZD': 'NZ\$',
    'SEK': 'kr',
    'NOK': 'kr',
    'DKK': 'kr',
    'PLN': 'zł',
    'CZK': 'Kč',
    'HUF': 'Ft',
    'RON': 'lei',
    'BGN': 'лв',
    'HRK': 'kn',
    'TRY': '₺',
    'ILS': '₪',
    'THB': '฿',
    'MYR': 'RM',
    'PHP': '₱',
    'IDR': 'Rp',
    'VND': '₫',
    'PKR': '₨',
    'LKR': '₨',
    'BDT': '৳',
    'NPR': '₨',
    'MUR': '₨',
    'FJD': 'FJ\$',
    'SBD': 'SI\$',
    'VUV': 'VT',
    'WST': 'WS\$',
    'TOP': 'T\$',
  };

  /// Gets the currency symbol for a given currency code
  static String getCurrencySymbol(String? currencyCode) {
    if (currencyCode == null || currencyCode.isEmpty) {
      return '\$'; // Default to USD
    }
    
    final upperCode = currencyCode.toUpperCase();
    return _currencySymbols[upperCode] ?? upperCode;
  }

  /// Formats a numeric value as a currency string
  /// 
  /// [amount] - The numeric value to format
  /// [currencyCode] - Currency code like "USD", "NGN", etc. (optional)
  /// [symbol] - Currency symbol (overrides currencyCode if provided)
  /// [decimalDigits] - Number of decimal places (default: 2)
  /// 
  /// Returns formatted currency string, e.g. "$1,234.56" or "₦1,234.56"
  static String formatCurrency(
    dynamic amount, {
    String? currencyCode,
    String? symbol,
    int decimalDigits = 2,
  }) {
    // Use provided symbol or get from currency code
    final currencySymbol = symbol ?? getCurrencySymbol(currencyCode);
    if (amount == null) {
      return '${currencySymbol}0.00';
    }
    
    double value;
    if (amount is String) {
      value = double.tryParse(amount) ?? 0.0;
    } else if (amount is num) {
      value = amount.toDouble();
    } else {
      value = 0.0;
    }
    
    // Format with decimal places
    String formattedValue = value.toStringAsFixed(decimalDigits);
    
    // Add thousands separator
    final parts = formattedValue.split('.');
    String integerPart = parts[0];
    String decimalPart = parts.length > 1 ? parts[1] : '';
    
    // Add comma separators for thousands
    if (integerPart.length > 3) {
      String reversed = integerPart.split('').reversed.join('');
      String withCommas = reversed.replaceAllMapped(
        RegExp(r'.{3}'),
        (match) => '${match.group(0)},',
      );
      integerPart = withCommas.split('').reversed.join('');
      if (integerPart.startsWith(',')) {
        integerPart = integerPart.substring(1);
      }
    }
    
    return '$currencySymbol$integerPart${decimalPart.isNotEmpty ? '.$decimalPart' : ''}';
  }
  
  /// Formats a numeric value as a simple currency string without thousands separators
  /// 
  /// [amount] - The numeric value to format
  /// [symbol] - Currency symbol (default: '$')
  /// [decimalDigits] - Number of decimal places (default: 2)
  /// 
  /// Returns simple formatted currency string, e.g. "$1234.56"
  static String formatSimpleCurrency(
    dynamic amount, {
    String symbol = '\$',
    int decimalDigits = 2,
  }) {
    if (amount == null) {
      return '${symbol}0.00';
    }
    
    double value;
    if (amount is String) {
      value = double.tryParse(amount) ?? 0.0;
    } else if (amount is num) {
      value = amount.toDouble();
    } else {
      value = 0.0;
    }
    
    return '$symbol${value.toStringAsFixed(decimalDigits)}';
  }
  
  /// Parses a currency string back to a double
  /// 
  /// [currencyString] - The currency string to parse
  /// 
  /// Returns the numeric value as double
  static double parseCurrency(String currencyString) {
    // Remove currency symbols and commas
    String cleanString = currencyString
        .replaceAll(RegExp(r'[$,€£¥]'), '')
        .trim();
    
    return double.tryParse(cleanString) ?? 0.0;
  }
}
