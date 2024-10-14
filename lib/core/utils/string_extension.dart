import 'package:intl/intl.dart';

extension DateStringFormatting on String {
  String toFormattedDate() {
    // Check if the string can be parsed to a DateTime
    try {
      DateTime dateTime = DateTime.parse(this);
      // Format the DateTime object to 'dd MMM yyyy'
      return DateFormat('dd MMM yyyy').format(dateTime);
    } catch (e) {
      // Return the original string if parsing fails
      return this; // or handle error as needed
    }
  }
}
