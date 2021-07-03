import 'package:astrometry_net/resources/storage.dart';
import 'package:astrometry_net/widgets/page_layout.dart';
import 'package:astrometry_net/widgets/preferences/switch_preference.dart';
import 'package:astrometry_net/widgets/preferences/text_preference.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      title: 'Settings',
      child: ValueListenableBuilder(
        valueListenable: Storage.settingsBox.listenable(),
        builder: (context, Box<dynamic> box, widget) {
          return ListView(
            children: [
              TextPreference(
                value: Storage.getApiKey(),
                onChanged: (value) {
                  final oldValue = Storage.getApiKey();
                  if (oldValue != value) {
                    Storage.saveApiKey(value);

                    /// clear current session
                    Storage.saveSessionKey('');
                  }
                },
                title: 'API Key',
                hint: 'You can find API key in "Dashboard" > "My Profile" at nova.astrometry.net website'
              ),
              SizedBox(height: 16),

              
              SwitchPreference(
                value: Storage.getDarkThemeEnabled(),
                title: 'Use dark theme',
                onChanged: (value) {
                  Storage.saveDarkThemeEnabled(value);
                },
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  launch('https://nova.astrometry.net/');
                },
                child: Text('Go to https://nova.astrometry.net/',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}