import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'souvenir.dart';
import 'substringFinder.dart';

class CounterStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<String> readCounter() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return "";
    }
  }

  Future<File> writeCounter(String counter) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString(counter);
  }
}

String saveDay(
  String inFile,
  DateTime date,
  List<TextEditingController> controllers,
  CounterStorage storage,
) {
  //what was found
  String jsonResult = inFile;
  //the found with corrected json
  String jsond = jsonResult + "]}";
  //the parsed json
  final parsedJson = jsonDecode(jsond);

  final memory = Memoir.fromJson(parsedJson);
  if (memory.memo.last['Date'].toString() ==
      [date.day, date.month, date.year].toString()) {
    //if date already written
    final indexes = findSubs(jsonResult, "},{");
    //find last day start in memory
    jsonResult = jsonResult.substring(0, indexes.last + 1);
    //make jsond wto/ last day
    //jsond = jsonResult + "]}";
  }

  jsonResult += ",{";
  jsonResult +=
      "\"Date\" : [${date.day},${date.month},${date.year}],\"souvenirs\":[";
  for (int i = 0; i < controllers.length; i++) {
    jsonResult += "\"" + controllers[i].text + "\"";
    if (i < controllers.length - 1) {
      jsonResult += ",";
    }
  }
  jsonResult += "]}";
  storage.writeCounter(jsonResult);
  return jsonResult;
}
