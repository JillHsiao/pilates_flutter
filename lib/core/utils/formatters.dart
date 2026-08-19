import 'package:intl/intl.dart';

final _currency = NumberFormat.currency(
  locale: 'zh_TW',
  symbol: 'NT\$',
  decimalDigits: 0,
);
String money(num value) => _currency.format(value);
String uiDate(String? value) =>
    value == null || value.isEmpty ? '—' : value.replaceAll('-', '/');
String apiDate(DateTime value) => DateFormat('yyyy-MM-dd').format(value);
String today() => apiDate(DateTime.now());
const lessonLabels = {
  'Completed': '已上課',
  'Leave': '請假',
  'Cancelled': '取消',
  'Makeup': '補課',
};
const paymentLabels = {
  'Cash': '現金',
  'Transfer': '轉帳',
  'LinePay': 'LINE Pay',
  'CreditCard': '信用卡',
  'Other': '其他',
};
