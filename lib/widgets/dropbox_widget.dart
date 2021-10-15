import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visualvend/utils/dimens.dart';
import 'package:visualvend/utils/themes.dart';

class DropDownWidget extends StatelessWidget {
  final List<String> spinnerItems;
  final String selectedText;
  final Function onChanged;
  final Color textColor;
  final Color spinColor;
  final Color iconColor;
  final Color backColor;
  final bool isExpanded;

  const DropDownWidget({
    Key key,
    @required this.spinnerItems,
    @required this.selectedText,
    @required this.onChanged,
    this.textColor = Colors.black,
    this.spinColor = Colors.white,
    this.iconColor = Colors.black,
    this.backColor,
    this.isExpanded = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      padding: EdgeInsets.symmetric(horizontal: 6),
      margin: EdgeInsets.only(top: 6),
      child: DropdownButton<String>(
        value: selectedText,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        iconEnabledColor: iconColor,
        style: TextStyle(color: spinColor, fontSize: fontBase,),
        isExpanded: isExpanded,
        underline: Container(
          height: 1,
          color: Colors.transparent,
        ),
        onChanged: (String data) {
          onChanged(data);
        },
        items: spinnerItems.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value, style: semiBold.copyWith(fontSize: fontBase, color: textColor),),
          );
        }).toList(),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(offsetSm)),
        color: backColor,
      ),
    );
  }
}