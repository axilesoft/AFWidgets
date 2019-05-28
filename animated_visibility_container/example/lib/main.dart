import 'dart:math';

import 'package:flutter/material.dart';
import 'package:animated_visibility_container/animated_visibility_container.dart' as avc;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'AnimatedVisibilityContainer Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _visible = true;
  void _incrementCounter() {
    setState(() {
      _visible = !_visible;
      if (_visible)
        avcid++;
    });
  }

  List<avc.AnimatedChildBuilder> builders=[
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
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(color: Colors.amberAccent,shadows: [Shadow(offset: Offset(0,3),blurRadius: 3)]),
                textAlign: TextAlign.center)),
      );
    },


  ];

  static int avcid=0;

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
            aniChildBuilder: builders[(avcid)%builders.length]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.touch_app),
      ),
    );
  }
}
