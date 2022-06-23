import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

class destroyMemory extends StatefulWidget {
  const destroyMemory({Key? key}) : super(key: key);

  @override
  State<destroyMemory> createState() => _destroyMemoryState();
}

class _destroyMemoryState extends State<destroyMemory>
    with TickerProviderStateMixin {
  @override
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final TextEditingController textControl = TextEditingController();

  void statusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _controller.stop();
    }
  }

  Widget build(BuildContext context) {
    _controller.addStatusListener(statusListener);
    return Scaffold(
      appBar: AppBar(title: Text("Forget machine")),
      body: Container(
        child: Column(
          children: [
            TwirlableTextField(
              controller: _controller,
              t_c: TextEditingController(),
            ),
            Card(
              color: Theme.of(context).colorScheme.error,
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
                side: BorderSide.none,
              ),
              child: SizedBox(
                width: 150,
                child: IconButton(
                  icon: const Icon(Icons.delete_forever),
                  color: Theme.of(context).backgroundColor,
                  iconSize: 50,
                  onPressed: () {
                    setState(() {
                      print("Hello world");
                      _controller.forward().then((value) {
                        textControl.clear();
                        _controller.reverse();
                      });
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
              child: Divider(),
            ),
            Text(
              "here you can write everything that is wrong today, and then, click on the button to toss it somewhere never to be seen again",
            ),
          ],
        ),
      ),
    );
  }
}

class TwirlableTextField extends AnimatedWidget {
  TwirlableTextField({
    Key? key,
    required AnimationController controller,
    required this.t_c,
  }) : super(
          key: key,
          listenable: controller,
        );

  @override
  Animation<double> get _progress => listenable as Animation<double>;

  TextEditingController t_c;
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: math.sin(_progress.value * 15 * math.pi) / 10,
      child: Card(
        elevation: 3.0,
        color: Theme.of(context).cardTheme.color,
        child: Container(
          color: Theme.of(context).cardColor,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(6, 2, 0, 2),
            child: TextField(
              controller: t_c,
              maxLines: null,
              onChanged: (String value) {},
              style: Theme.of(context).textTheme.headline5,
              decoration: InputDecoration(
                hintText: "What would you want to foget ?",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
