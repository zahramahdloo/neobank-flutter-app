class MoneyFormatter {
  MoneyFormatter._();

  static String toman(int amount) {
    final sign = amount < 0 ? '-' : '';
    final value = amount.abs().toString();

    final buffer = StringBuffer();
    int count = 0;

    for (int i = value.length - 1; i >= 0; i--) {
      buffer.write(value[i]);
      count++;

      if (count == 3 && i != 0) {
        buffer.write(',');
        count = 0;
      }
    }

    final reversed = buffer.toString().split('').reversed.join();
    return '$sign$reversed تومان';
  }
}
