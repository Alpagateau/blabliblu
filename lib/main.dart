import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:blabliblu/loadingIcon.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

import 'package:path_provider/path_provider.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

import 'aboutPageWidget.dart';
import 'memorySaving.dart';
import 'souvenir.dart';
import 'api/notification_push.dart';
import 'themes.dart' as themes;
import 'historyPage.dart';
import 'homePage.dart';

//TODO Notifs seem to work :?
//TODO Export data and load data
//TODO Animations

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

  runApp(const MeApp());
}

class MeApp extends StatelessWidget {
  const MeApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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
      ],
      home: MyHomePage(
        title: 'Blabliblu',
        storage: CounterStorage()
      ),
    );
  }
}

// ignore: must_be_immutable
