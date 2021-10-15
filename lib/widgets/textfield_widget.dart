import 'package:flutter/material.dart';
import 'package:visualvend/utils/themes.dart';

class NoOutLineTextField extends TextField {
  NoOutLineTextField({
    Key key,
    @required TextEditingController controller,
    String hint,
    TextInputType keyboardType,
    double textSize = 16.0,
    EdgeInsets padding = EdgeInsets.zero,
    TextAlign textAlign = TextAlign.left,
    int maxLine = 1,
    Color hintColor = Colors.grey,
  }) : super (
    controller: controller,
    keyboardType: keyboardType,
    textAlign: textAlign,
    decoration: InputDecoration(
      contentPadding: padding,
      hintText: hint,
      hintStyle: mediumText.copyWith(fontSize: textSize, color: hintColor),
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
    ),
    minLines: 1,
    maxLines: maxLine,
    showCursor: true,
    readOnly: keyboardType == null? true : false,
  );
}