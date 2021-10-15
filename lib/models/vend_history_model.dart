
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visualvend/utils/dimens.dart';
import 'package:visualvend/utils/themes.dart';

class VendHistory {
  String vendTitle;
  String vendTime;
  String vendItem;
  String vendCash;
  String vendMc;
  String vendCH;
  String vendCost;
  String vendCc;

  VendHistory({this.vendTitle = '', this.vendTime = '', this.vendItem = '', this.vendCash = '', this.vendMc = '',
    this.vendCH = '', this.vendCost = '', this.vendCc = '', });
}

class VendHistoryUI extends StatelessWidget {
  final VendHistory vHistory;
  final int historyIndex;
  final Function onClicked;

  const VendHistoryUI(this.vHistory, this.historyIndex, this.onClicked,);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if(historyIndex != 0)Container(
          height: 1,
          margin: EdgeInsets.symmetric(horizontal: 6),
          color: Colors.blue.withOpacity(0.7),
        ),
        InkWell(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                Container(
                  width: 78,
                  child: Text(vHistory.vendTime, style:  semiBold.copyWith(fontSize: fontSm, color: Colors.black),),
                  alignment: Alignment.topLeft,
                ),
                Expanded(child:
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(vHistory.vendTitle, style:  semiBold.copyWith(fontSize: fontSm, color: Colors.black), ),
                        Text('item ' + vHistory.vendItem, style:  semiBold.copyWith(fontSize: fontSm, color: Colors.black),),
                        vHistory.vendMc != '' ? Text('Mc ' + vHistory.vendMc, style:  semiBold.copyWith(fontSize: fontSm, color: Colors.black),) : Container(),
                        vHistory.vendCash != '' ? Text('Cash ' + vHistory.vendCash, style:  semiBold.copyWith(fontSize: fontSm, color: Colors.black),) : Container(),
                        vHistory.vendCH != '' ? Text('Cash ' + vHistory.vendCH, style:  semiBold.copyWith(fontSize: fontSm, color: Colors.black),) : Container(),
                      ],
                    ),
                  )
                ),
                Container(
                  width: 90,
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\$ ' + vHistory.vendCost, style:  semiBold.copyWith(fontSize: fontSm, color: Colors.black), ),
                      Text('CC ' + vHistory.vendCc, style:  semiBold.copyWith(fontSize: fontSm, color: Colors.black),),
                    ],
                  ),
                ),
              ],
            ),
          ),
          onTap: ()=>{
            onClicked(historyIndex),
          },
        ),
      ],
    );
  }
}