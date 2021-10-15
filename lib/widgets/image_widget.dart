import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:visualvend/utils/colors.dart';
import 'package:visualvend/utils/constants.dart';

class IconWidget extends Container {
  IconWidget({
    @required dynamic icon,
    @required ICONTYPE iconType,
    double size = 24.0,
    double padding = 2.0,
    Color color = primaryColor,
}) : super (
    width: size,
    height: size,
    padding: EdgeInsets.all(padding),
    child: iconType == ICONTYPE.IconData ?
    Icon(icon, size: size - padding * 2, color: color,) :
    iconType == ICONTYPE.Image ?
    Image.asset(icon, width: size - padding * 2, height: size - padding * 2, color: color,) :
    SvgPicture.asset(icon, width: size - padding * 2, height: size - padding * 2, color: color,)
  );
}

class CircleIconWidget extends Container {
  CircleIconWidget({
    Key key,
    @required dynamic icon,
    @required ICONTYPE iconType,
    double size = 24.0,
    double padding = 8.0,
    double margin = 4.0,
    Color color = primaryColor,
    Color background = primaryColor
}) : super (
    width: size - margin * 2,
    height: size - margin * 2,
    margin: EdgeInsets.all(margin),
    padding: EdgeInsets.all(padding),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular((size - margin * 2) / 2)),
      color: background,
    ),
    child: iconType == ICONTYPE.IconData ?
      Icon(icon, size: size - margin * 2 - padding * 2, color: color,) : iconType == ICONTYPE.Image ?
      Image.asset(icon, width: size - margin * 2 - padding * 2, height: size - margin * 2 - padding * 2, color: color,) :
      SvgPicture.asset(icon, width: size - margin * 2 - padding * 2, height: size - margin * 2 - padding * 2, color: color,)
  );
}