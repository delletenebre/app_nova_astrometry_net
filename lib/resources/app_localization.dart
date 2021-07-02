import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class AppLocalization {
  static AppLocalizations of(BuildContext context) {
    return AppLocalizations.of(context)!;
  }

  static String get systemLocale {
    return Intl.systemLocale.substring(0, 2);
  }

  static final Map<String, String> locales = <String, String>{
    'en': 'English',
    'ru': 'Русский',
  };
}