class Money {
  final double amount;
  final String currency; // "USD", "EUR", ...
  const Money(this.amount, this.currency);

  String format({String locale = 'en_US'}) {
    // lightweight formatting without intl
    // e.g. "$12.34 USD"
    final value = amount.toStringAsFixed(2);
    return '$value $currency';
  }
}
