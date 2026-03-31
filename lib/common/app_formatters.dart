import 'package:intl/intl.dart';

class AppFormatters {
  AppFormatters._();

  static final _amountFormat = NumberFormat('#,##0.00', 'en_US');

  static String amount(double value) => _amountFormat.format(value);
}
