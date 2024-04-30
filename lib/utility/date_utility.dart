import 'package:intl/intl.dart';

class DateUtility {
  static final DateFormat _dataFormat = DateFormat('yyyy-MM-dd');

  static String formatDate(DateTime date) {
    return _dataFormat.format(date);
  }

  static String currentFormattedDate() {
    DateTime currentDate = DateTime.now();
    return DateUtility.formatDate(currentDate);
  }
}
