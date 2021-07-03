import 'package:astrometry_net/pages/home_page.dart';
import 'package:astrometry_net/pages/job_page.dart';
import 'package:astrometry_net/pages/settings_page.dart';
import 'package:astrometry_net/resources/app_theme.dart';
import 'package:astrometry_net/resources/storage.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
      valueListenable: Storage.settingsBox.listenable(),
      builder: (context, box, widget) {
        var darkMode = Storage.getDarkThemeEnabled();

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          
          title: 'Astrometry.net',

          themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          
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
    );
  }
}