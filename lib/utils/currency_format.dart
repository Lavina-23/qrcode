import 'package:intl/intl.dart';

class CurrencyFormat {
  static String formatToIDR(int number) {
    NumberFormat formatIDR = NumberFormat.currency(locale: 'id', symbol: 'Rp ');
    return formatIDR.format(number);
  }
}
