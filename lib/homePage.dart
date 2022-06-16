// ignore_for_file: file_names

// ignore: library_names
library homePage;

import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:blabliblu/api/utilities.dart';
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

part 'settingPage.dart';

///Main page of the App
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.storage})
      : super(key: key);
  final String title;
  final CounterStorage storage;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

///State of [MyHomePage]
class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  ///number of memory cells +1
  int _counter = 4;

  ///today's date
  DateTime today = DateTime.now();

  ///path to the local storage, made to be shown in the [AboutPage]
  String filePath = "##############";

  ///Bool value, show the JSON file of everything that has been saved by the app
  bool showContent = false;

  ///Bool value, send notifications to the user
  bool schedulNotifs = false;

  ///Int value, setting to choose the language of the app, not used yet
  int languageSetting = 0;

  ///Int value, theme setting:
  ///- 0 : same as local
  ///- 1 : Light theme
  ///- 2 : Dark theme
  int themeS = 0;

  ///Number of days where the user wrote something.
  ///Seted up in [asyncLoader]
  int flames = 0;

  ///List of Strings, possibles languages, not used yet
  List<String> PossiblesLanguages = [
    "System's language",
    "English",
    "Français"
  ];

  ///list of all the [TextEditingController]s assigned to memory cells
  ///Their must be [_counter]-1 values
  List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  ///increments [_counter] by one, and ass a new [TextEditingController] to the [controllers]
  void _incrementCounter() {
    setState(() {
      _counter++;
      controllers.add(TextEditingController());
      controllers.last.addListener(textEditListener);
    });
  }

  void resetCounter() {
    setState(() {
      _counter = 4;
      controllers = [controllers[0], controllers[1], controllers[2]];
    });
  }

  bool showImageButton = false;
  int selectedField = -1;

  void showImageOption(bool showI, int index) {
    setState(() {
      showImageButton = showI;
      selectedField = index;
    });
  }

  Future<String> getImagePath() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    //print("<#{Img}#>" + image!.path);
    if (image == null) {
      return "";
    }
    final directory = await getApplicationDocumentsDirectory();
    final String path = directory.path;

    final fileName = p.basename(image.path);
    final fPath = '$path/$fileName';
    image.saveTo('$path/$fileName');

    controllers[selectedField].text = "<#{Img}#>" + fPath;
    textEditListener();
    return "<#{Img}#>" + image.path;
  }

  bool isThisImage(String content) {
    if (content.length > 9) {
      if (content.substring(0, 9) == "<#{Img}#>") {
        print(content);
        print("This is an Image 1");
        return true;
      }
    }
    return false;
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    for (int i = 0; i < controllers.length; i++) {
      controllers[i].addListener(textEditListener);
    }
    asyncLoader();
  }

  void asyncLoader() async {
    await Future.delayed(const Duration(milliseconds: 2), () {});
    Directory dir = await getApplicationDocumentsDirectory();
    filePath = dir.path;
    setState(() {
      widget.storage.readCounter().then((String message) {
        if (message != "") {
          inFile = message;
        } else {
          inFile = "{\"Memory\" : [{}";
        }

        final String jsond = inFile + "]}";
        final parsedJson = jsonDecode(jsond);
        final a = Memoir.fromJson(parsedJson);

        if (a.memo.last['Date'].toString() ==
            [today.day, today.month, today.year].toString()) {
          _counter = a.memo.last['souvenirs'].length + 1;
          controllers = [];
          for (int i = 0; i < _counter - 1; i++) {
            controllers.add(TextEditingController());
            controllers.last.text = a.memo.last['souvenirs'][i];
          }
        }
        stderr.writeln('print me !!!!');
        flames = flamesFromMemoir(a);
        print("===========================>$flames<=======================");

        SharedPreferences.getInstance().then((value) {
          try {
            schedulNotifs =
                value.getBool("notifs")! ? value.getBool("notifs")! : false;
          } catch (e) {
            print(e);
          }
          try {
            showContent =
                value.getBool("contentS")! ? value.getBool("contentS")! : false;
          } catch (e) {
            print(e);
          }
          try {
            languageSetting =
                value.getInt("langS") != 0 ? value.getInt("langS")! : 0;
          } catch (e) {
            print(e);
          }
          try {
            themeS = value.getInt("themeS") != 0 ? value.getInt("themeS")! : 0;
          } catch (e) {
            print(e);
          }
        });

        AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
          if (!isAllowed) {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: const Text("Allow notifications"),
                      content: const Text(
                          "Our app would like to send you notifications"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            createReminderNotification(1, 18, 30);
                            createReminderNotification(2, 18, 30);
                            createReminderNotification(3, 18, 30);
                            createReminderNotification(4, 18, 30);
                            createReminderNotification(5, 18, 30);
                            createReminderNotification(6, 18, 30);
                            createReminderNotification(7, 18, 30);
                          },
                          child: const Text(
                            'Don\'t Allow',
                            style: TextStyle(color: Colors.grey, fontSize: 18),
                          ),
                        ),
                        TextButton(
                            onPressed: () => AwesomeNotifications()
                                .requestPermissionToSendNotifications()
                                .then((value) => Navigator.pop(context)),
                            child: const Text(
                              'Allow',
                              style: TextStyle(
                                color: Colors.teal,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ))
                      ],
                    ));
          }
        });
      });
    });
  }

  String inFile = "";

  void showWhatIsInside() {
    widget.storage.readCounter().then((String message) {
      if (message == "{\"Memory\" : [{}") {
        inFile = "{\"Memory\" : [{}";
      }
      saveDay(inFile, today, controllers, widget.storage);
      showDialog(
          context: context,
          builder: (context) {
            String value =
                showContent ? message : AppLocalizations.of(context)!.saved;
            return AlertDialog(
              backgroundColor: Theme.of(context).backgroundColor,
              content: Text(
                value,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          });
    });
  }

  void textEditListener() {
    setState(() {});
  }

  late AnimationController controller;

  @override
  Widget build(BuildContext context) {
    final Future<String> _waiting = Future<String>.delayed(
      const Duration(seconds: 2),
      () => 'Data Loaded',
    );

    return Theme(
      data: Theme.of(context),
      child: FutureBuilder<String>(
        future: _waiting, // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = [
              Stack(
                children: <Widget>[
                  Center(
                    child: ((Theme.of(context).backgroundColor == Colors.white)
                        ? Image.asset("assets/images/shamBG.png")
                        : null),
                  ),
                  Center(
                    child: Visibility(
                      visible: (flames > 2),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton.icon(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.orange),
                          ),
                          icon: Icon(Icons.local_fire_department),
                          onPressed: (() {}),
                          label: Text(
                            "$flames Days in a row",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    // Center is a layout widget. It takes a single child and positions it
                    // in the middle of the parent.
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: ListView.builder(
                        itemCount: _counter + 1,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            return buildDateLabel("${today.day}",
                                "${today.month}", "${today.year}");
                          } else if (index == _counter) {
                            return buildAddButton("oe");
                          }
                          return buildSouvenirCard(
                            controllers[index - 1],
                            index - 1,
                            isThisImage(controllers[index - 1].text),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              )
            ];
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ];
          } else {
            children = <Widget>[
              Center(
                child: SizedBox(
                    width: 180,
                    height: 180,
                    //child: CircularProgressIndicator(),
                    child: loadingIcon()),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting data...'),
              )
            ];
          }

          //set floating button List
          List<Widget> floatingButtons() {
            final buttons = [
              Container(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: FloatingActionButton(
                    heroTag: "save",
                    onPressed: showWhatIsInside,
                    tooltip: 'Save',
                    child: const Icon(Icons.check),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: FloatingActionButton(
                    onPressed: getImagePath,
                    heroTag: "image",
                    tooltip: 'Image',
                    child: const Icon(Icons.image),
                  ),
                ),
              )
            ];
            return showImageButton ? buttons : [buttons[0]];
          }

          return Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: AppBar(
              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
              title: Text(widget.title),
            ),
            drawer: Drawer(
              child: Container(
                color: Theme.of(context).backgroundColor,
                child: ListView(
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Blabliblu",
                              style: Theme.of(context).textTheme.headline1),
                          Text(AppLocalizations.of(context)!.shortDescribe,
                              style: Theme.of(context).textTheme.headline2),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.info,
                        color: Theme.of(context).textTheme.subtitle2?.color,
                      ),
                      title: Text(
                        AppLocalizations.of(context)!.about,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AboutPage(
                                      pathE: filePath,
                                    )));
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.history,
                        color: Theme.of(context).textTheme.subtitle2?.color,
                      ),
                      title: Text(
                        AppLocalizations.of(context)!.diary,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HistoryPage(
                                      storage: widget.storage,
                                      fileStor: inFile,
                                      context: context,
                                    )));
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.settings,
                        color: Theme.of(context).textTheme.subtitle2?.color,
                      ),
                      title: Text(
                        AppLocalizations.of(context)!.options,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Theme(
                                    data: themes.MainTheme,
                                    child: SettingsPage(
                                      storage: widget.storage,
                                      home: this,
                                    ))));
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.share,
                        color: Theme.of(context).textTheme.subtitle2?.color,
                      ),
                      title: Text(
                        AppLocalizations.of(context)!.share,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      onTap: () {
                        shareApp(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
            body: children[0], //normalement c'est bon
            floatingActionButton: Container(
              child: Column(
                verticalDirection: VerticalDirection.up,
                children: floatingButtons(),
              ),
            ),
            // This trailing comma makes auto-formatting nicer for build methods.
          );
        },
      ),
    );
  }

  Widget buildSouvenirCard(
      TextEditingController controller, int index, bool isImage) {
    return Stack(
      children: [
        Card(
          elevation: 3.0,
          color: Theme.of(context).cardTheme.color,
          child: Container(
            color: Theme.of(context).cardColor,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(6, 2, 0, 2),
              child: Column(
                children: [
                  Visibility(
                    visible: !isImage,
                    child: TextField(
                      controller: controller,
                      maxLines: null,
                      onTap: () {
                        showImageOption(true, index);
                      },
                      onChanged: (String value) {
                        print("###########################################");
                        if (value.length > 9) {
                          if (value.substring(0, 9) == "<#{Img}#>") {
                            print("This is an Image");
                          }
                        }
                      },
                      style: Theme.of(context).textTheme.headline5,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.enterMoment,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isImage,
                    child: isImage
                        ? Image.file(
                            File(
                              controllers[index].text.substring(9),
                            ),
                          )
                        : Text(""),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          alignment: AlignmentDirectional.bottomEnd,
          child: Visibility(
            visible: isImage,
            child: FloatingActionButton.small(
              onPressed: () {
                final dir = Directory(
                  controllers[index].text.substring(9),
                );
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(content: Text("Deleted"));
                    });
                dir.deleteSync(recursive: true);
                controllers[index].text = "";
              },
              backgroundColor: Colors.red,
              heroTag: "delete" + index.toString(),
              child: const Icon(
                Icons.delete,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildAddButton(String s) {
    return Card(
      color: Theme.of(context).primaryColor,
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
        side: BorderSide.none,
      ),
      child: IconButton(
        icon: const Icon(Icons.add),
        color: Theme.of(context).backgroundColor,
        iconSize: 50,
        onPressed: () {
          _incrementCounter();
        },
      ),
    );
  }

  Widget buildDateLabel(String d, String m, String y) {
    return Card(
        elevation: 0,
        shape: const RoundedRectangleBorder(side: BorderSide.none),
        color: Theme.of(context).backgroundColor,
        child: Center(
          child: Text(
            d + "/" + m + "/" + y,
            style: Theme.of(context).textTheme.headline3,
          ),
        ));
  }
}
