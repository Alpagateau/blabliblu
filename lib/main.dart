import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

import 'souvenir.dart';

void main() {
  runApp(const MeApp());
}

class MeApp extends StatelessWidget {
  const MeApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
          cardTheme: CardTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
              side: const BorderSide(color: Colors.grey, width: 1.2),
            ),
            clipBehavior: Clip.antiAlias,
          ),
        ),
        home: MyHomePage(title: 'Me', storage: CounterStorage()));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.storage})
      : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final CounterStorage storage;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

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

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _counter = 4;
  DateTime today = DateTime.now();

  List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      controllers.add(TextEditingController());
    });
  }

  void resetCounter() {
    setState(() {
      _counter = 4;
      controllers = [controllers[0], controllers[1], controllers[2]];
    });
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    widget.storage.readCounter().then((String message) {
      if (message != "") {
        inFile = message;
      } else {
        inFile = "{\"Memory\" : [{}";
      }
    });
  }

  String inFile = "";

  void showWhatIsInside() {
    widget.storage.readCounter().then((String message) {
      if (message == "{\"Memory\" : [{}") {
        print("It is supposed to delet");
        inFile = "{\"Memory\" : [{}";
      }
      saveDay();
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(content: Text(message));
          });
    });
  }

  void saveDay() {
    String jsonResult = inFile;

    final String jsond = jsonResult + "]}";
    final parsedJson = jsonDecode(jsond);

    final a = Memoir.fromJson(parsedJson);
    if (a.memo.last['Date'].toString() ==
        [today.day, today.month, today.year].toString()) {
      print("Today alreday done");
    } else {
      jsonResult += ",{";
      jsonResult +=
          "\"Date\" : [${today.day},${today.month},${today.year}],\"souvenirs\":[";
      for (int i = 0; i < controllers.length; i++) {
        jsonResult += "\"" + controllers[i].text + "\"";
        if (i < controllers.length - 1) {
          jsonResult += ",";
        }
      }
      jsonResult += "]}";
    }
/*
    jsonResult += ",{";
    jsonResult +=
        "\"Date\" : [${today.day},${today.month},${today.year}],\"souvenirs\":[";
    for (int i = 0; i < controllers.length; i++) {
      jsonResult += "\"" + controllers[i].text + "\"";
      if (i < controllers.length - 1) {
        jsonResult += ",";
      }
    }
    jsonResult += "]}";
*/
    widget.storage.writeCounter(jsonResult);
  }

  late AnimationController controller;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.green,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    "HappyMe",
                    style: TextStyle(
                      fontSize: 38,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Every day, just type 3 good things that happend.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  )
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text("About"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text("Diary"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HistoryPage(
                              storage: widget.storage,
                              fileStor: inFile,
                            )));
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Options"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SettingsPage(
                              storage: widget.storage,
                              home: this,
                            )));
              },
            ),
          ],
        ),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: ListView.builder(
            itemCount: _counter + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return buildDateLabel(
                    "${today.day}", "${today.month}", "${today.year}");
              } else if (index == _counter) {
                return buildAddButton("oe");
              }
              return buildSouvenirCard(controllers[index - 1]);
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showWhatIsInside,
        tooltip: 'Increment',
        child: const Icon(Icons.check),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget buildSouvenirCard(TextEditingController controller) {
    return Card(
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(6, 2, 0, 2),
        child: TextField(
          controller: controller,
          maxLines: null,
          style: (const TextStyle(
            fontSize: 20,
            fontFamily: 'Raleway',
          )),
          decoration: const InputDecoration(
            hintText: "Enter your good moment",
          ),
        ),
      ),
    );
  }

  Widget buildAddButton(String s) {
    return Card(
      color: Colors.green,
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
        side: BorderSide.none,
      ),
      child: IconButton(
        icon: const Icon(Icons.add),
        color: Colors.white,
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
        child: Center(
          child: Text(
            d + "/" + m + "/" + y,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Raleway'),
          ),
        ));
  }
}

class HistoryPage extends StatefulWidget {
  HistoryPage({Key? key, required this.storage, required this.fileStor})
      : super(key: key);

  List<String> getValues() {
    return [""];
  }

  CounterStorage storage;
  String fileStor;
  Widget buildSouvenirCard(int D, int M, int Y, List<String> souv) {
    List<Widget> cards = [
      Text(
        "$D/$M/$Y",
        style: const TextStyle(
            fontSize: 25, fontWeight: FontWeight.bold, fontFamily: 'Raleway'),
      )
    ];
    for (int i = 0; i < souv.length; i++) {
      Widget card = Card(
        elevation: 1,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              souv[i],
              style: const TextStyle(fontSize: 16, fontFamily: 'Raleway'),
            ),
          ),
        ),
      );
      cards.add(card);
    }

    print(cards.length.toString() + "/*\\" + souv.length.toString());

    return Card(
        elevation: 0.5,
        color: Colors.grey[350],
        child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
            child: Center(child: Column(children: cards))));
  }

  @override
  HistoryPageState createState() => HistoryPageState();
}

class HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("History"),
        ),
        body: ListView(
          children: [
            FutureBuilder<String>(
              future: widget.storage
                  .readCounter(), // a previously-obtained Future<String> or null
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                List<Widget> days;
                List<Widget> children;
                if (snapshot.hasData) {
                  final String jsond = (snapshot.data as String) + "]}";
                  //print("1st = >" + jsond);
                  final parsedJson = jsonDecode(jsond);

                  final b = Memoir.fromJson(parsedJson);

                  int lenght = b.memo.length - 1;
                  final souv = b.memo.sublist(1);

                  //print("Heres memory == >" + souv[0].toString());

                  List<Widget> a = [];
                  for (int i = 0; i < souv.length; i++) {
                    a.add(widget.buildSouvenirCard(
                        souv[i]['Date'][0],
                        souv[i]['Date'][1],
                        souv[i]['Date'][2],
                        List<String>.from(souv[i]['souvenirs'])));
                  }
                  children = <Widget>[
                    const Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Center(
                          child: ListBody(
                        children: a,
                      )),
                    ),
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
                  children = const <Widget>[
                    SizedBox(
                      child: CircularProgressIndicator(),
                      width: 60,
                      height: 60,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Awaiting result...'),
                    )
                  ];
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: children,
                  ),
                );
              },
            ),
          ],
        ));
  }
}

// ignore: must_be_immutable
class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key, required this.storage, required this.home})
      : super(key: key);

  CounterStorage storage;
  _MyHomePageState home;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    bool _ShowMemory = false;

    return Scaffold(
        appBar: AppBar(
          title: const Text("History"),
        ),
        body: ListView(
          children: [
            const Padding(
              padding: const EdgeInsets.fromLTRB(4, 16, 4, 0),
              child: const Text(
                "Memory settings",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
            const Divider(),
            TextButton(
                onPressed: () {
                  widget.storage.writeCounter("{\"Memory\":[{}");
                  widget.home.inFile = "{\"Memory\":[{}";
                  // ignore: avoid_print
                  print('or');
                },
                child: const Text(
                  "Delete Memory",
                  style: TextStyle(fontSize: 18),
                )),
            TextButton(
                onPressed: () {
                  widget.home.resetCounter();
                },
                child: const Text(
                  "Reset Counter",
                  style: TextStyle(fontSize: 18),
                )),
            CheckboxListTile(
              title: const Text('Animate Slowly'),
              value: timeDilation != 1.0,
              onChanged: (bool? value) {
                setState(() {
                  timeDilation = value! ? 10.0 : 1.0;
                });
              },
              secondary: const Icon(Icons.hourglass_empty),
            )
          ],
        ));
  }
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("About")));
  }
}
