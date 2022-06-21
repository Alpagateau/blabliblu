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
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("YESS")),
      body: Container(
        child: Column(
          children: [
            TwirlableTextField(controller: _controller),
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
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TwirlableTextField extends AnimatedWidget {
  const TwirlableTextField({
    Key? key,
    required AnimationController controller,
  }) : super(key: key, listenable: controller);

  @override
  // TODO: implement listenable
  Animation<double> get _progress => listenable as Animation<double>;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Transform.rotate(
      angle: math.sin(_progress.value * 20) / 10,
      child: Card(
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
    );
  }
}
