import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

String formatNumber(dynamic) {
  var f = NumberFormat('###,00');
  if (dynamic == null) {
    return "";
  }
  return f.format(dynamic);
}

Image imageFromString(String input) {
  return Image.memory(base64Decode(input));
}

String formatDate(DateTime date) {
  return DateFormat('dd.MM.yyyy').format(date.toLocal());
}

String formatDateTime(String date) {
  return DateFormat('dd.MM.yyyy HH:mm').format(DateTime.parse(date).toLocal());
}

String formatCurrency(num? value) {
  if (value == null) return '';
  return NumberFormat('#,##0.00', 'bs_BA').format(value);
}