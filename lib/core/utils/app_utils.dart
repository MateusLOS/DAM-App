import 'package:intl/intl.dart';

class AppUtils {
  static String formatDate(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
  }
}