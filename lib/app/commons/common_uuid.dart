// ignore_for_file: depend_on_referenced_packages

import 'package:uuid/uuid.dart';

class CommonUuidHelper {
  static String getUuid() {
    return const Uuid().v4();
  }
}
