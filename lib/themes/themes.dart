import 'package:blabliblu/src/api/utilities.dart';
import 'package:flutter/material.dart';

ColorScheme darkColorScheme = const ColorScheme(
  brightness: Brightness.dark,
  primary: Color.fromARGB(255, 13, 152, 186),
  onPrimary: Color.fromARGB(255, 200, 200, 255),
  secondary: Color.fromARGB(255, 11, 135, 167),
  onSecondary: Color.fromARGB(255, 255, 255, 255),
  background: Color.fromARGB(255, 32, 38, 56),
  onBackground: Color.fromARGB(255, 150, 150, 200),
  surface: Color.fromARGB(255, 13, 152, 186),
  onSurface: Color.fromARGB(255, 255, 255, 255),
  error: Color.fromARGB(255, 215, 71, 71),
  onError: Color.fromARGB(255, 255, 255, 255),
  primaryVariant: Color.fromARGB(255, 13, 170, 186),
  secondaryVariant: Color.fromARGB(255, 196, 100, 189),
);

final DarkTheme = ThemeData(
  colorScheme: darkColorScheme,
  primarySwatch: fromRGB(
    darkColorScheme.primary.red,
    darkColorScheme.primary.green,
    darkColorScheme.primary.blue,
  ),
  backgroundColor: darkColorScheme.background,
  cardTheme: CardTheme(
    color: darkColorScheme.secondaryVariant,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(32.0),
      side: const BorderSide(color: Colors.grey, width: 1.2),
    ),
    clipBehavior: Clip.antiAlias,
  ),
  buttonTheme: ButtonThemeData(buttonColor: darkColorScheme.primary),
  textTheme: TextTheme(
    //Title only (Blabliblu)
    headline1: const TextStyle(
      fontSize: 38,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    //Subtitles
    headline2: const TextStyle(
      color: Colors.white,
      fontSize: 25,
    ),
    //Date in main page
    headline3: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      fontFamily: 'Raleway',
      color: Color.fromARGB(255, 200, 200, 230),
    ),
    //date in cards
    headline4: const TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold,
      fontFamily: 'Raleway',
    ),
    //Text in textFields
    headline5: const TextStyle(
      fontSize: 22,
      fontFamily: 'Raleway',
    ),
    //memories bottom text
    headline6: const TextStyle(
      fontSize: 19,
      color: Colors.grey,
    ),
    //Settings
    subtitle1: const TextStyle(
      color: Color.fromARGB(255, 50, 50, 50),
    ),
    //Buttons on the side
    subtitle2: TextStyle(
      color: darkColorScheme.onBackground,
    ),
    // Test in the about
    caption: const TextStyle(
      color: Colors.black,
    ),
  ),
);

final MainTheme = ThemeData(
  colorScheme: mainColorScheme,
  primarySwatch: fromRGB(
    mainColorScheme.primaryVariant.red,
    mainColorScheme.primaryVariant.green,
    mainColorScheme.primaryVariant.blue,
  ),
  backgroundColor: mainColorScheme.background,
  cardTheme: CardTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(32.0),
      side: const BorderSide(color: Colors.grey, width: 1.2),
    ),
    clipBehavior: Clip.antiAlias,
  ),
  buttonTheme: ButtonThemeData(buttonColor: mainColorScheme.primaryVariant),
  textTheme: TextTheme(
    //Title only (Blabliblu)
    headline1: const TextStyle(
      fontSize: 38,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    //Subtitles
    headline2: const TextStyle(
      color: Colors.white,
      fontSize: 25,
    ),
    //Date in main page
    headline3: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      fontFamily: 'Raleway',
      color: Color.fromARGB(255, 100, 100, 100),
    ),
    //date in cards
    headline4: const TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold,
      fontFamily: 'Raleway',
    ),
    //Text in textFields
    headline5: const TextStyle(
      fontSize: 22,
      fontFamily: 'Raleway',
    ),
    //memories bottom text
    headline6: const TextStyle(
      fontSize: 19,
      color: Colors.grey,
    ),
    //Settings
    subtitle1: const TextStyle(
      color: Color.fromARGB(255, 50, 50, 50),
    ),
    //Buttons on the side
    subtitle2: TextStyle(
      color: Colors.grey[800],
    ),
    // Test in the about
    caption: const TextStyle(
      color: Colors.black,
    ),
  ),
);

ColorScheme mainColorScheme = const ColorScheme(
  brightness: Brightness.light,
  primary: Color.fromARGB(255, 76, 175, 80),
  onPrimary: Color.fromARGB(255, 255, 255, 255),
  secondary: Color.fromARGB(255, 81, 211, 86),
  onSecondary: Color.fromARGB(255, 255, 255, 255),
  background: Color.fromARGB(255, 255, 255, 255),
  onBackground: Color.fromARGB(255, 0, 0, 0),
  surface: Color.fromARGB(255, 118, 208, 121),
  onSurface: Color.fromARGB(255, 255, 255, 255),
  error: Color.fromARGB(255, 255, 82, 82),
  onError: Color.fromARGB(255, 255, 255, 255),
  primaryVariant: Color.fromARGB(255, 76, 175, 80),
  secondaryVariant: Color.fromARGB(255, 100, 211, 100),
);
