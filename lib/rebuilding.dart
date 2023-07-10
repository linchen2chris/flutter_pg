import 'dart:async';
import 'package:flutter/material.dart';

class RebuildWidget extends StatefulWidget {
  const RebuildWidget({Key? key}) : super(key: key);

  @override
  _RebuildWidgetState createState() => _RebuildWidgetState();
}

class _RebuildWidgetState extends State<RebuildWidget> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('rebuilding ${_timer.tick}');
    return Container(
      child: Text('rebuilding ${_timer.tick}'),
    );
  }
}
