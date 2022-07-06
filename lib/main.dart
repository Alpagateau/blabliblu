import 'package:awesome_notifications/awesome_notifications.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import 'src/database/memorySaving.dart';
import 'themes/themes.dart' as themes;
import 'views/homePage.dart';

//TODO Notifs seem to work :?, not anymore
//TODO Export data and load data
//TODO Animations

//TODO widget on the main page ?
//TODO in app review DOING THAT Rn
//TODO maybe try "once" for the notifications
//TODO implement fl_charts
//TODO make a show case, with show case view
//TODO add intro sliders
//TODO implement name of the person

///Lauches the app and setup a the notification channels
///Is launched when the app is called
void main() {
  AwesomeNotifications().initialize(
      'resource://drawable/res_app_icon',
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic Notifications',
          defaultColor: Colors.teal,
          importance: NotificationImportance.High,
          channelShowBadge: true,
        ),
        NotificationChannel(
          channelKey: 'scheduled_channel',
          channelName: 'Scheduled Notifications',
          defaultColor: Colors.teal,
          importance: NotificationImportance.High,
          channelShowBadge: true,
        ),
      ],
      debug: true);
  //debugRepaintRainbowEnabled = true;
  runApp(const MeApp());
}

///The main widget
class MeApp extends StatelessWidget {
  const MeApp({Key? key}) : super(key: key);

  ///Builds the application and initiate the localization
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Blabliblu',
      theme: themes.MainTheme,
      darkTheme: themes.DarkTheme,
      themeMode: ThemeMode.system,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('fr', ''), // French, no country code
        Locale('es', ''), // Spanish, no country code
        Locale('pt', ''), // Portuguese, no country code
        Locale('sk', ''), // Slovak, no country code
        Locale('hi', ''), // Hindi, no country code
      ],

      /// lauches the main page with a [title] and a [storage] for memory management
      home: MyHomePage(title: 'Blabliblu', storage: CounterStorage()),
    );
  }
}

// ignore: must_be_immutable
