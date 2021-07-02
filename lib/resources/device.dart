import 'package:package_info_plus/package_info_plus.dart';

class Device {
  static String appName = '';
  static String packageName = '';
  static String buildVersion = '';
  static String buildNumber = '';
  static String installationId = '';

  static Future<void> initialize() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appName = packageInfo.appName;
    packageName = packageInfo.packageName;
    buildVersion = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
  }
}