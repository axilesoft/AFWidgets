import 'package:flutter/material.dart';
import 'package:animated_listview/animated_listview.dart';
import 'package:vector_math/vector_math_64.dart';

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
      curALV = (curALV + 1);
    });
  }

  final animatedListViewBuilders = <AnimatedItemBuilder>[
        (BuildContext context, int index,Animation ani) {
      double aniValue=ani.value;
      Size ss = MediaQuery.of(context).size;
      double scl = 3- 2 * aniValue;
      double trx = (index % 2 * 2 - 1) * ss.width * 0.5 * (1.0 - aniValue);

      return Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001) // perspective

          ..translate(trx,0, 0)..scale(scl)
        ,
        alignment: Alignment.center,
        child: Opacity(
          //key: PageStorageKey<MediaItem>(widget.entry),
          opacity: aniValue.clamp(0.0, 1.0),
          child: Container(
            height: 32,
            padding: EdgeInsets.all(2),
            alignment: Alignment.center,
            child: Container(
              height: 28,
              child: RaisedButton(
                highlightColor:
                HSLColor.fromAHSL(1.0, index * 6.0 % 360, 1, 0.8).toColor(),
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                color:
                HSLColor.fromAHSL(1.0, index * 6.0 % 360, 1, 0.5).toColor(),
                child: Text(                   "ITEM ID=$index"), //,AniIdx=$_aniIdx,DelayMs=$delayMs  |  ${widget.entry.title} "),
                onPressed: () {},
              ),
            ),
          ),
        ),
      );
    },

        (BuildContext context, int index, Animation ani) {
      double aniValue=ani.value;
      Size ss = MediaQuery.of(context).size;
      double scl = 0 + 1 * aniValue;
      double trl =  ss.width * 1 * (1.0 - aniValue);
      double roY = radians(-90*(1.0-aniValue));
      return Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001) // perspective
          ..rotateY(roY),
        //alignment: Alignment.center,
        child: Container(
          height: 50,
          padding: EdgeInsets.all(2),


          child: RaisedButton(
            highlightColor:
            HSLColor.fromAHSL(1.0, index * 6.0 % 360, 1, 0.8).toColor(),
            color:
            HSLColor.fromAHSL(1.0, index * 6.0 % 360, 1, 0.5).toColor(),
            child: Text(
                "ITEM ID=$index"), //,AniIdx=$_aniIdx,DelayMs=$delayMs  |  ${widget.entry.title} "),
            onPressed: () {},
          ),
        ),
      );
    },

        (BuildContext context, int index,Animation ani) {
      double aniValue=ani.value;
      Size ss = MediaQuery.of(context).size;
      double scl = 0 + 1 * aniValue;
      double trl = ss.width * 0.5 * (1.0 - aniValue);
      return Opacity(
        //key: PageStorageKey<MediaItem>(widget.entry),
        opacity: aniValue.clamp(0.0, 1.0),
        child: Container(
          height: 50,
          padding: EdgeInsets.all(1),
          transform: Matrix4.translationValues(
            trl,
            0,
            0, //(widget.idx%2 *2-1)*ss.width*5.5*(1.0-aniVal)
          ) *
              Matrix4.diagonal3Values(scl, scl, 1),
          child: RaisedButton(
            highlightColor:
            HSLColor.fromAHSL(1.0, index * 6.0 % 360, 1, 0.8).toColor(),
            // color:                HSLColor.fromAHSL(1.0, index * 6.0 % 360, 1, 0.5).toColor(),
            child: Text(
                "ITEM ID=$index"), //,AniIdx=$_aniIdx,DelayMs=$delayMs  |  ${widget.entry.title} "),
            onPressed: () {},
          ),
        ),
      );
    },





  ];

  int curALV = 0;
  List<int> li= List<int>.generate(1000,(index)=>index);
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
        aniItemBuilder: animatedListViewBuilders[curALV % animatedListViewBuilders.length],

        itemCount: 100,
        aniDurMs: 1000,
        aniIntervalMs: 50,
        aniCurve: Curves.bounceOut,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}




class TestWidget extends StatefulWidget {
  final int id;
  TestWidget(this.id);

  @override
  _TestWidgetState createState() =>  _TestWidgetState();


}

class _TestWidgetState extends State<TestWidget> {


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('${widget.id}'),
    );
  }

  @override
  void initState() {
    super.initState();
    //_dbgPrint('+ ${widget.id}');
  }

  @override
  void dispose() {
   // _dbgPrint('- ${widget.id}');
    super.dispose();
  }
}

///debug log
void _dbgPrint(String message, {int wrapWidthParam}) {
  assert((){debugPrint(message,wrapWidth:wrapWidthParam);return true;}());
}