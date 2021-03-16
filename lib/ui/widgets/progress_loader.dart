import 'package:flutter/material.dart';

class ProgressLoader extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _ProgressState();
}

class _ProgressState extends State<ProgressLoader> with SingleTickerProviderStateMixin {

  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 2))..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * 3.14,
          child: child,
        );
      },
      child: Icon(
        Icons.sync,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

