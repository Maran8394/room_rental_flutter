import 'package:flutter/material.dart';

extension MediaQuerySizeExtension on BuildContext {
  Size get size => MediaQuery.of(this).size;
  double get deviceHeight => MediaQuery.of(this).size.height;
  double get deviceWidth => MediaQuery.of(this).size.width;
  double get gapHeight => MediaQuery.of(this).size.height * 0.02;
  double get gapHeight2 => MediaQuery.of(this).size.height * 0.04;
  double get labelGap => MediaQuery.of(this).size.height * 0.01;
  double get buttonHeight => MediaQuery.of(this).size.height *  0.06;

}
