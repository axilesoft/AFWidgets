// Copyright 2019 Axilesoft (axilesoft.com). All rights reserved.
// Use of this source code is governed by a MIT-license that can be
// found in the LICENSE file.


library animated_listview;

import 'package:flutter/material.dart';


void dbgPrint(String message, {int wrapWidthParam}) {
  assert((){debugPrint(message,wrapWidth:wrapWidthParam);return true;}());
}

typedef AnimatedItemBuilder = Widget Function(
    BuildContext context,
    int index,            /// item index
    double aniValue,      /// Animation value (from 0 to 1)
    );


/// The Animated ListView widget of this package, with item showing animation
class AnimatedListView extends StatefulWidget {
  AnimatedListView({
    Key key,
    this.itemCount,
    @required this.aniItemBuilder,
    this.aniDurMs=1000,
    this.aniIntervalMs=33,
    this.aniCurve=Curves.easeOut,

  }):super(key:key);

  /// Animation Duration (-Ms: milliseconds)
  final int aniDurMs;

  /// Animation Interval
  final int aniIntervalMs;

  /// Animation Curve
  final Curve aniCurve;

  /// Item count, see itemCount of [ListView.builder]
  final int itemCount;


  /// Create item widget callback, see [AnimatedItemBuilder]
  final AnimatedItemBuilder aniItemBuilder;


  @override
  _AnimatedListViewState createState() =>  _AnimatedListViewState();
}

class _AnimatedListViewState extends State<AnimatedListView>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  ListView _listView;
  ScrollController sclCtlr;
  bool firstShow = true;  // first screen of items should show one by one with a delay.
  DateTime lvBuildTime;
  int aniId = 0;


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    sclCtlr = ScrollController()
      ..addListener(() {
        //dbgPrint('scroll pos=${_sclCtlr.offset/50} ofs=${_sclCtlr.offset}');
      });


  }



  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    firstShow = true;
    aniId = 0;
    lvBuildTime = DateTime.now();
    return Container(
      child: _listView = ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          dbgPrint('build $index');
          if (DateTime.now().difference(lvBuildTime) >
              Duration(milliseconds: widget.aniDurMs)) firstShow = false;
          return LvAniItem(//PageStorageKey<T>(getItem(index)),
              index, widget.aniDurMs, widget.aniIntervalMs,widget.aniCurve, this, widget.aniItemBuilder);
        },
        itemCount: widget.itemCount,
        controller: sclCtlr,
      ),
    );
  }
}

class LvAniItem extends StatefulWidget {
  LvAniItem(
      //this.key,
      this.idx, this.durMs, this.intvMs, this.aniCurve, this.lv,this.cbCreateItem){
    dbgPrint('LvItem Widget create $idx');
  }

  final AnimatedItemBuilder cbCreateItem;
  final Curve aniCurve;

  //final Key key;
  final int idx;

  final int durMs;
  final int intvMs;
  final _AnimatedListViewState lv;
  int showCount = 0;
  @override
  _LvAniItemState createState() => _LvAniItemState(idx);
}

class _LvAniItemState extends State<LvAniItem>
    with SingleTickerProviderStateMixin {
  Animation<double> _ani;
  AnimationController _aniCtl;
  double ratioOf1ms = 0.0001;
  int delayMs;
  bool firstShow = true;
  int buildCount = 0;
  _LvAniItemState(int idx){
    dbgPrint('LvItem State create $idx');
  }
  int _aniIdx;

  @override
  void initState() {
    super.initState();
    firstShow = widget.showCount == 0 && widget.lv.firstShow;

//    if (firstShow && widget.lv.sclCtlr.position.haveDimensions) {
//      double itemBeg = widget.lv.sclCtlr.offset / 50;
//      double itemEnd = (widget.lv.sclCtlr.offset +
//          widget.lv.sclCtlr.position.viewportDimension) / 50;
//      dbgPrint('LvItem initState idx:${widget.idx}  $itemBeg->$itemEnd');
//    }

    _aniIdx = (widget.lv.aniId++).clamp(0, 32);
    delayMs = firstShow ? _aniIdx * widget.intvMs.toInt() : 0;
    var totalMs = widget.durMs  + delayMs.toInt();
    ratioOf1ms = 1 / totalMs;
    _aniCtl = new AnimationController(
      duration: Duration(milliseconds: totalMs),
      vsync: this,
      // lowerBound: -100.0
    );
    // ..value=widget.idx*0.1;
    _ani = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _aniCtl,
        curve: Interval(delayMs * ratioOf1ms, 1.0, curve:widget.aniCurve)
      //autoInterval(0,0.0,Curves.easeOutBack)
    ));
    _ani.addListener(() {
      //dbgPrint('LvItem Listener idx:${widget.idx}  b.$buildCount');
      setState(() {});
    });

    _aniCtl.forward();

    widget.showCount++;
  }

  @override
  void dispose() {
    _aniCtl?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    buildCount++;
    // dbgPrint('LvItem build idx:${widget.idx}  b.$buildCount');
    // if (!_aniCtl.isAnimating) _aniCtl.forward();
    double aniVal = _ani.value;//firstShow && _ani != null ? _ani.value : 1.0;

    return widget.cbCreateItem(context,widget.idx, aniVal);
  }


}
