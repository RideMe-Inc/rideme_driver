import 'package:intl/intl.dart';

mixin DateFormatMixin {
  String formatDateToYMD(DateTime date) {
    return DateFormat.yMd().format(date);
  }
}
