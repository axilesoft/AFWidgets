import 'dart:math';

import 'package:flutter/material.dart';
import 'package:animated_visibility_container/animated_visibility_container.dart'
    as avc;

import 'common.dart';

class SampleRoute extends StatefulWidget {
  SampleRoute({Key key, this.title = 'AnimatedVisibilityContainer Sample'}) : super(key: key);

  final String title;

  @override
  _SampleRouteState createState() => _SampleRouteState();
}

class _SampleRouteState extends State<SampleRoute> {
  int _counter = 0;
  bool _visible = true;
  void _incrementCounter() {
    setState(() {
      _visible = !_visible;
      if (_visible) avcid++;
    });
  }

  List<avc.AnimatedChildBuilder> builders = [
    (BuildContext context, Animation ani) {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(-pi / 2 * (1 - ani.value)),
        child: Container(
            alignment: Alignment.center,
            color: Colors.indigoAccent,
            width: 300,
            height: 300,
            child: Text('Sample of AnimatedVisibilityContainer',
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(color: Colors.amberAccent),
                textAlign: TextAlign.center)),
      );
    },
    (BuildContext context, Animation ani) {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(-pi / 2 * (1 - ani.value)),
        child: Container(
            alignment: Alignment.center,
            color: Colors.indigoAccent,
            width: 300,
            height: 300,
            child: Text('Sample of AnimatedVisibilityContainer',
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(color: Colors.amberAccent),
                textAlign: TextAlign.center)),
      );
    },
    (BuildContext context, Animation ani) {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..rotateZ(-pi * 2 * (1 - ani.value))
          ..scale(ani.value),
        child: Container(
            alignment: Alignment.center,
            color: Colors.indigoAccent,
            width: 300,
            height: 300,
            child: Text('Sample of AnimatedVisibilityContainer',
                style: Theme.of(context).textTheme.title.copyWith(
                    color: Colors.amberAccent,
                    shadows: [Shadow(offset: Offset(0, 3), blurRadius: 3)]),
                textAlign: TextAlign.center)),
      );
    },
  ];

  static int avcid = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: avc.AnimatedVisibilityContainer(
            visible: _visible,
            aniDurMs: 300,
            aniChildBuilder: builders[(avcid) % builders.length]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.touch_app),
      ),
    );
  }
}
