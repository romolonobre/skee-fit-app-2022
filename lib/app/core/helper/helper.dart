import 'dart:developer';

class Helper {
  // String List Helper method
  //
  static List<String> getStringList(dynamic value) {
    if (value == null) {
      return <String>[];
    }

    final List<dynamic> listValue = value as List<dynamic>;

    final List<String> list = [];
    for (value in listValue) {
      final String newString = Helper.getString(value);

      list.add(newString);
    }

    return list;
  }

  // String Helper method
  //
  static String getString(dynamic valeu) {
    if (valeu == null) {
      return '';
    }

    if (valeu is int || valeu is double) {
      return valeu.toString();
    }

    if (valeu is String) {
      return valeu;
    }

    return '';
  }

  // int Helper method
  //
  static int getInt(dynamic value) {
    if (value == null) {
      return 0;
    }

    if (value is int) {
      return value;
    }

    if (value is double) {
      return value.toInt();
    }

    if (value is String) {
      try {
        if (value.isNotEmpty) {
          return int.parse(value);
        }
      } on Exception {
        print('erooo');
      }
    }
    return 0;
  }
}

void debuLog(dynamic data, [String? title]) {
  log('=============================================================');
  log(data.toString());
  log('=============================================================');
}
