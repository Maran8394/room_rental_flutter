import 'package:flutter/material.dart';

extension MediaQuerySizeExtension on BuildContext {
  Size get size => MediaQuery.of(this).size;
  double get deviceHeight => MediaQuery.of(this).size.height;
  double get deviceWidth => MediaQuery.of(this).size.width;
  double get gapHeight => MediaQuery.of(this).size.height * 0.02;
  double get labelGap => MediaQuery.of(this).size.height * 0.01;
}
