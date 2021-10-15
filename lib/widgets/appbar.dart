import 'package:flutter/material.dart';

class NoTitleAppBar extends AppBar {
  NoTitleAppBar({
    Key key,
    Brightness brightness = Brightness.dark,
  }) : super (
    backgroundColor: Colors.transparent,
    toolbarHeight: 0,
    elevation: 0,
    brightness: brightness,
  );
}