import 'package:astrometry_net/app.dart';
import 'package:flutter/material.dart';

import 'resources/device.dart';
import 'resources/storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Storage.initialize();
  await Device.initialize();

  runApp(App());
}
