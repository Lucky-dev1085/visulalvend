import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:visualvend/models/vend_machine_model.dart';
import 'package:visualvend/screens/qrcode/qr_scan_screen.dart';
import 'package:visualvend/services/navigator_service.dart';
import 'package:visualvend/utils/app_utils.dart';
import 'package:visualvend/utils/colors.dart';
import 'package:visualvend/utils/params.dart';
import 'package:visualvend/utils/sharedpref.dart';
import 'package:visualvend/utils/themes.dart';


class VendMenuScreen extends StatefulWidget {
  final String title;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function onCallback;
  final Function(int) onClickBackHome;
  const VendMenuScreen({Key key, this.onCallback, this.title, this.scaffoldKey, this.onClickBackHome, }) : super(key: key);

  @override
  _VendMenuScreenState createState() => _VendMenuScreenState();
}

class _VendMenuScreenState extends State<VendMenuScreen> {
  var badge = 0;
  List<VendMachine> vendMachines = <VendMachine>[];

  @override
  void initState() {
    badge = SharedPrefs.getInt(SharedPrefs.KEY_BADGE_VALUE);
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight, color: darkGreyColor,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          Container(
            width: double.infinity, height: 52,
            child: Stack(
              children: [
                Center(child: Text(widget.title, style: semiBold.copyWith(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),)),
                Row(
                  children: [
                    InkWell(
                      child: Container(
                        padding: EdgeInsets.only(left: 6, top: 8, right: 8, bottom: 8),
                        child: Icon(Icons.arrow_back_ios, size: 26, color: Colors.white,),
                      ),
                      onTap: (){
                        widget.onCallback();
                      },
                    ),
                  ],
                ),
              ],
              alignment: Alignment.centerLeft,
            ),
          ),
          SizedBox(height: 26,),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8),
              child: Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index){
                    return VendMachineUI(vendMachines.elementAt(index), index, (eventIndex){
                        onClickMachine(context, vendMachines.elementAt(eventIndex));
                      }
                    );
                  },
                  itemCount: vendMachines.length,
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                color: Colors.white,
              ),
            )
          ),
          SizedBox(height: 8,),
          Container(
            height: 56, width: screenWidth,
            child: Row(
              children: [
                Spacer(),
                Badge(
                  badgeContent: Text('3', style: TextStyle(color: Colors.white, fontSize: 16),),
                  child: Icon(Icons.shopping_cart_outlined, size: 34, color: getFocusColor(1, 1),),
                ),
                SizedBox(width: 12,),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void initData() {
    vendMachines.clear();
    for(int i=1; i < 13; i++){
      VendMachine machine = new VendMachine();
      machine.vID = '#123456789';
      machine.assetIcon = machineImages[i-1];
      machine.site = 'Site ' + i.toString();
      machine.location = machineLocations[i-1];
      machine.checkStatus = false;
      vendMachines.add(machine);
    }
    vendMachines.elementAt(0).checkStatus = true;
    setState(() {});
  }

  void onClickMachine(BuildContext _context, VendMachine elementAt) {
    showBanner(_context, widget.scaffoldKey, vendRequestToastData[0]['title'], vendRequestToastData[0]['type'], (){
        NavigatorService(context).pushToWidget(screen: QrCodeScreen(startFrgIndex: 1, canGoToProductMenu: true, onClickBackHome: widget.onClickBackHome,));
      }
    );
  }
}
