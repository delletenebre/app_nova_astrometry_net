import 'package:flutter/material.dart';

class PageArguments {
  static Map<String, dynamic> of(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null) {
      return arguments as Map<String, dynamic>;
    }

    return Map<String, dynamic>.from({});
  }
}