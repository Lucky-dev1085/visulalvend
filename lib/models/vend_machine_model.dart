import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visualvend/utils/dimens.dart';
import 'package:visualvend/utils/themes.dart';

class VendMachine {
  String vID;
  String assetIcon;
  String site;
  String location;
  bool checkStatus;

  VendMachine({this.vID = '', this.assetIcon = 'assets/icons/ic_vend_machine.png', this.site = '', this.location = '', this.checkStatus = false});
}

class NearbyVendMachineUI extends StatelessWidget {
  final VendMachine machine;
  final int vendIndex;
  final int selectedIndex;
  final Function onChangeStatus;

  const NearbyVendMachineUI(this.machine, this.vendIndex, this.selectedIndex, this.onChangeStatus,);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 36,
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Container(
              width: 74,
              child: Text(machine.site, style:  semiBold.copyWith(fontSize: fontBase, color: Colors.black),),
            ),
            Expanded(child: Container(
              padding: EdgeInsets.only(left: 6),
              child: Text(machine.location, style:  semiBold.copyWith(fontSize: fontBase, color: Colors.black),),
            )
            ),
            Container(
              width: 90,
              child: Row(
                children: [
                  Spacer(),
                  selectedIndex == vendIndex ?
                  Icon(Icons.check_circle, size: 16,)
                      : Icon(Icons.circle_outlined, size: 16,),
                  Container(width: 8,),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: ()=>{
        onChangeStatus(vendIndex)
      },
    );
  }
}

class VendMachineUI extends StatelessWidget {
  final VendMachine machine;
  final int vendIndex;
  final Function(int) onClickVendMachine;

  const VendMachineUI(this.machine, this.vendIndex, this.onClickVendMachine,);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 80,
        margin: EdgeInsets.only(top: 8),
        child: Row(children: [
            Container(
              width: 80,
              child: Image.asset(machine.assetIcon, width: 38,),
            ),
            Expanded(child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12,),
                    Text('Location: ' + machine.location, style:  semiBold.copyWith(fontSize: fontSm, color: Colors.black), maxLines: 1,),
                    Spacer(),
                    Text('Site: ' + machine.site, style:  semiBold.copyWith(fontSize: fontSm, color: Colors.black), maxLines: 1,),
                    Spacer(),
                    Text('ID : ' + machine.vID, style:  semiBold.copyWith(fontSize: fontSm, color: Colors.black), maxLines: 1,),
                    SizedBox(height: 8,),
                  ],
                ),
              )
            ),
          ],
        ),
      ),
      onTap: ()=>{
        onClickVendMachine(vendIndex)
      },
    );
  }
}