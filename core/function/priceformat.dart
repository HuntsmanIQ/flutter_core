import 'package:intl/intl.dart';

String priceFormat(String price) {
  NumberFormat formattedPrice = NumberFormat('###,###', 'en_US');
  return formattedPrice.format(int.parse(price));
}
