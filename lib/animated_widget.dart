import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class ExampleInfiniteAnimation extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _ExampleInfiniteAnimationState createState() =>
      _ExampleInfiniteAnimationState();
}

class _ExampleInfiniteAnimationState extends State<ExampleInfiniteAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..repeat();
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    print('build animated');
    return Center(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (BuildContext context, Widget? child) {
          return Transform.scale(
            scale: _animation.value,
            child: Container(
              width: 200.0,
              height: 200.0,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
