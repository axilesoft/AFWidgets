import 'package:flutter/material.dart';
import 'package:animated_listview/animated_listview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      //theme: ThemeData.dark(),
      home: MyHomePage(title: 'AFWidgets Demo - animated_listview'),
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
  AnimatedListView _alv;
  void _incrementCounter() {
    setState(() {
      curALV = (curALV + 1) % animatedListViewBuilders.length;
    });
  }

  final animatedListViewBuilders = <AnimatedItemBuilder>[
    /// a demo builder
    (BuildContext context, int index, double aniValue) {
      Size ss = MediaQuery.of(context).size;
      double scl = 0 + 1 * aniValue;
      double trl = (index % 2 * 2 - 1) * ss.width * 0.5 * (1.0 - aniValue);
      return Opacity(
        //key: PageStorageKey<MediaItem>(widget.entry),
        opacity: aniValue.clamp(0.0, 1.0),
        child: Center(
          child: Container(
            height: 50,
            padding: EdgeInsets.all(2),
            transform: Matrix4.translationValues(
                  trl,
                  0,
                  0, //(widget.idx%2 *2-1)*ss.width*5.5*(1.0-aniVal)
                ) *
                Matrix4.diagonal3Values(scl, scl, 1),
            child: RaisedButton(
              highlightColor:
                  HSLColor.fromAHSL(1.0, index * 6.0 % 360, 1, 0.8).toColor(),
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              color:
                  HSLColor.fromAHSL(1.0, index * 6.0 % 360, 1, 0.5).toColor(),
              child: Text(
                  "Id=$index"), //,AniIdx=$_aniIdx,DelayMs=$delayMs  |  ${widget.entry.title} "),
              onPressed: () {},
            ),
          ),
        ),
      );
    },

    /// another demo builder
    (BuildContext context, int index, double aniValue) {
      Size ss = MediaQuery.of(context).size;
      double scl = 0 + 1 * aniValue;
      double trl = ss.width * 0.5 * (1.0 - aniValue);
      return Opacity(
        //key: PageStorageKey<MediaItem>(widget.entry),
        opacity: aniValue.clamp(0.0, 1.0),
        child: Center(
          child: Container(
            height: 50,
            padding: EdgeInsets.all(2),
            transform: Matrix4.translationValues(
                  trl,
                  0,
                  0, //(widget.idx%2 *2-1)*ss.width*5.5*(1.0-aniVal)
                ) *
                Matrix4.diagonal3Values(scl, scl, 1),
            child: RaisedButton(
              highlightColor:
                  HSLColor.fromAHSL(1.0, index * 6.0 % 360, 1, 0.8).toColor(),
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              color:
                  HSLColor.fromAHSL(1.0, index * 6.0 % 360, 1, 0.5).toColor(),
              child: Text(
                  "Id=$index"), //,AniIdx=$_aniIdx,DelayMs=$delayMs  |  ${widget.entry.title} "),
              onPressed: () {},
            ),
          ),
        ),
      );
    },
  ];
  int curALV = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: _alv = AnimatedListView(
        key: new ObjectKey(curALV),
        aniItemBuilder: animatedListViewBuilders[curALV],
        itemCount: 100,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
