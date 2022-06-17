import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class destroyMemory extends StatefulWidget {
  const destroyMemory({Key? key}) : super(key: key);

  @override
  State<destroyMemory> createState() => _destroyMemoryState();
}

class _destroyMemoryState extends State<destroyMemory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("YESS")),
      body: Container(
        child: Column(
          children: [
            Card(
              elevation: 3.0,
              color: Theme.of(context).cardTheme.color,
              child: Container(
                color: Theme.of(context).cardColor,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(6, 2, 0, 2),
                  child: TextField(
                    maxLines: null,
                    onChanged: (String value) {},
                    style: Theme.of(context).textTheme.headline5,
                    decoration: InputDecoration(
                      hintText: "TEST",
                    ),
                  ),
                ),
              ),
            ),
            Card(
              color: Theme.of(context).disabledColor,
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
                side: BorderSide.none,
              ),
              child: IconButton(
                icon: const Icon(Icons.add),
                color: Theme.of(context).backgroundColor,
                iconSize: 50,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
