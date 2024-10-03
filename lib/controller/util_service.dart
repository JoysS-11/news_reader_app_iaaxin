import 'package:intl/intl.dart';

String format1 = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
String format2 = "yyyy-MM-dd HH:mm:ss.SSS'Z'";

class UtilService {
  static DateTime stingToDateTime(String date) {
    var inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
    return inputFormat.parse(date);
  }

  static String formatingStringDate(String date, String format) {
    var outputFormat = DateFormat(format);
    return outputFormat.format(stingToDateTime(date));
  }
}
