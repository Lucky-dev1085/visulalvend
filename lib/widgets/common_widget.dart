import 'package:flutter/cupertino.dart';
import 'package:visualvend/utils/colors.dart';

class DividerWidget extends Container {
  DividerWidget({
    Key key,
    double thick = 1.0,
    EdgeInsets padding = EdgeInsets.zero,
  }) : super (
    width: double.infinity,
    height: thick,
    padding: padding,
    color: normalGreyColor
  );
}