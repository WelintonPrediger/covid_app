class Conversion {

  static String convertData(String date) {
    DateTime dateTime = DateTime.parse(date);
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

}