import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'memorySaving.dart';
import 'souvenir.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage(
      {Key? key,
      required this.storage,
      required this.fileStor,
      required this.context})
      : super(key: key);

  List<String> getValues() {
    return [""];
  }

  CounterStorage storage;
  String fileStor;
  BuildContext context;
  Widget buildSouvenirCard(int D, int M, int Y, List<String> souv) {
    List<Widget> cards = [
      Text(
        "$D/$M/$Y",
        style: Theme.of(context).textTheme.headline4,
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
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        ),
      );
      cards.add(card);
    }
    return Card(
        elevation: 0.5,
        color: Theme.of(context).focusColor,
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
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.diary,
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        body: ListView(
          children: [
            FutureBuilder<String>(
              future: widget.storage
                  .readCounter(), // a previously-obtained Future<String> or null
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                //List<Widget> days;
                List<Widget> children;
                if (snapshot.hasData) {
                  final String jsond = widget.fileStor + "]}";

                  final parsedJson = jsonDecode(jsond);

                  final b = Memoir.fromJson(parsedJson);

                  final souv = b.memo.sublist(1);

                  List<Widget> finalList = [];
                  for (int i = 0; i < souv.length; i++) {
                    finalList.add(widget.buildSouvenirCard(
                        souv[i]['Date'][0],
                        souv[i]['Date'][1],
                        souv[i]['Date'][2],
                        List<String>.from(souv[i]['souvenirs'])));
                  }
                  finalList.add(Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        AppLocalizations.of(context)!.nothingToSee,
                        style: Theme.of(context).textTheme.headline6,
                      )));
                  children = <Widget>[
                    Icon(
                      Icons.check_circle_outline,
                      color: Theme.of(context).primaryColor,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Center(
                          child: ListBody(
                        children: finalList,
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
