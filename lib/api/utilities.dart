import 'dart:io';

import 'package:blabliblu/souvenir.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_share/flutter_share.dart';

int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}

class NotificationWeekAndTime {
  final int dayOfTheWeek;
  final TimeOfDay timeOfDay;

  NotificationWeekAndTime({
    required this.dayOfTheWeek,
    required this.timeOfDay,
  });
}

Future<NotificationWeekAndTime?> pickSchedule(
  BuildContext context,
) async {
  List<String> weekdays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];
  TimeOfDay? timeOfDay;
  DateTime now = DateTime.now();
  int? selectedDay;

  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'I want to be reminded every:',
            textAlign: TextAlign.center,
          ),
          content: Wrap(
            alignment: WrapAlignment.center,
            spacing: 3,
            children: [
              for (int index = 0; index < weekdays.length; index++)
                ElevatedButton(
                  onPressed: () {
                    selectedDay = index + 1;
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.teal,
                    ),
                  ),
                  child: Text(weekdays[index]),
                ),
            ],
          ),
        );
      });

  if (selectedDay != null) {
    timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(
          now.add(
            const Duration(minutes: 1),
          ),
        ),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData(
              colorScheme: const ColorScheme.light(
                primary: Colors.teal,
              ),
            ),
            child: child!,
          );
        });

    if (timeOfDay != null) {
      return NotificationWeekAndTime(
          dayOfTheWeek: selectedDay!, timeOfDay: timeOfDay);
    }
  }
  return null;
}

Future<void> shareApp(BuildContext context) async {
  await FlutterShare.share(
      title: AppLocalizations.of(context)!.shareTitle,
      text: AppLocalizations.of(context)!.shareMsg,
      linkUrl:
          'https://play.google.com/store/apps/details?id=com.alpagames.blabliblu',
      chooserTitle: 'Example Chooser Title');
}

Future<void> shareMessage(BuildContext context, String txt,
    {String title = ""}) async {
  await FlutterShare.share(
    title: title,
    text: txt,
    linkUrl:
        'https://play.google.com/store/apps/details?id=com.alpagames.blabliblu',
  );
}

int flamesFromMemoir(Memoir m) {
  DateTime? d1 = null;
  int i = 0;
  int f = 0;
  bool stop = false;
  stderr.writeln('print me !!!!');
  final souv = m.memo.sublist(1).reversed.toList();
  if (souv.length == 0) {
    print("WAIIIT");
    return 0;
  }
  do {
    final date = souv[i]['Date'];
    d1 = new DateTime(date[2], date[1], date[0]);
    Duration z = d1.difference(
      new DateTime(souv[i + 1]["Date"][2], souv[i + 1]["Date"][1],
          souv[i + 1]["Date"][0]),
    );
    if (z.inDays == 1) {
      i++;
      f++;
    } else {
      stop = true;
    }
  } while (!stop);
  return f + 1;
}
