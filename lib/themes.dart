import 'package:flutter/material.dart';

final MainTheme = ThemeData(
  primarySwatch: Colors.green,
  backgroundColor: Colors.white,
  cardTheme: CardTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(32.0),
      side: const BorderSide(color: Colors.grey, width: 1.2),
    ),
    clipBehavior: Clip.antiAlias,
  ),
);

final DarkTheme = ThemeData(
  primarySwatch: Colors.deepPurple,
  backgroundColor: Colors.grey[900],
  //scaffoldBackgroundColor: Colors.grey[500],
  cardColor: Colors.green[900],
  hintColor: Colors.green[100],
  cardTheme: CardTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(32.0),
      side: BorderSide(color: Colors.grey, width: 1.2),
    ),
    clipBehavior: Clip.antiAlias,
  ),
);
