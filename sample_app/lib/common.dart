import 'package:flutter/widgets.dart';

///debug log
void dbgPrint(String message, {int wrapWidthParam}) {
  assert(() {
    debugPrint(message, wrapWidth: wrapWidthParam);
    return true;
  }());
}
