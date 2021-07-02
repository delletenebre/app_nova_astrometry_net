import 'package:astrometry_net/pages/home_page.dart';
import 'package:astrometry_net/pages/job_page.dart';
import 'package:astrometry_net/pages/settings_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      title: 'Astrometry.net',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        late Widget page;

        switch(settings.name) {

          case '/settings':
            page = SettingsPage();
            break;

          case '/job':
            page = JobPage();
            break;

          case '/':
          default:
            page = HomePage();

        }

        return MaterialPageRoute(
          builder: (_) => page,
          settings: settings
        );
      },
    );
  }
}