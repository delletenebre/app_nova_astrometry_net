
import 'dart:developer';

class AppLog {
  static const ENABLED = true;

  static d(String message) {
    if (ENABLED) {
      log(message);
    }
  }

  static e(String message) {
    if (ENABLED) {
      print(message);
    }
  }
}