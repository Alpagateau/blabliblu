import 'package:flutter/material.dart';

class loadingIcon extends StatefulWidget {
  @override
  _loadingIconState createState() => _loadingIconState();
}

class _loadingIconState extends State<loadingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.repeat();
    return Center(
      child: RotationTransition(
        //turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
        turns: CurveTween(curve: Curves.easeInOut).animate(_controller),
        child: Image.asset(
          "assets/images/loadingIcon.png",
          scale: 0.5,
        ),
      ),
    );
  }
}
