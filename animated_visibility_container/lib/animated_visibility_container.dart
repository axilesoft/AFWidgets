library animated_visibility_container;

import 'package:flutter/material.dart';

typedef AnimatedChildBuilder = Widget Function(
  BuildContext context,

  /// Animation value (from 0 to 1)
  Animation ani,
);

class AnimatedVisibilityContainer extends StatefulWidget {
  /// visibility
  final bool visible;

  /// animation duration (-Ms: milliseconds)
  final int aniDurMs;

  /// animation Curve
  final Curve aniCurve;

  /// child widget builder
  final AnimatedChildBuilder aniChildBuilder;

  AnimatedVisibilityContainer(
      {this.visible = true,
      this.aniDurMs = 200,
      this.aniCurve = Curves.linear,
      @required this.aniChildBuilder});

  @override
  _AnimatedVisibilityContainerState createState() =>
      _AnimatedVisibilityContainerState();
}

class _AnimatedVisibilityContainerState
    extends State<AnimatedVisibilityContainer>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _ani;
  bool _visible = false;
  bool _needBuild = false;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: widget.aniDurMs),
      vsync: this,
    )..addStatusListener((AnimationStatus status) {
        _dbgPrint('Ani status=$status visible=${widget.visible} $_visible  ');
        setState(() {
          _needBuild = !(status == AnimationStatus.dismissed);
        });
      });
    _ani = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: widget.aniCurve))
          ..addListener(() {
            setState(() {});
          });

    updateVisibility();

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(AnimatedVisibilityContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateVisibility();
  }

  void updateVisibility() {
    _dbgPrint('Visible $_visible -> ${widget.visible}');
    if (_visible != widget.visible) {
      _visible = widget.visible;
      if (widget.visible)
        _controller.forward();
      else
        _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _needBuild?widget.aniChildBuilder(context, _ani):Container();
  }
}

void _dbgPrint(String message, {int wrapWidthParam}) {
  assert(() {
    debugPrint(message, wrapWidth: wrapWidthParam);
    return true;
  }());
}
