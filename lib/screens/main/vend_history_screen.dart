import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visualvend/models/menu_option_model.dart';
import 'package:visualvend/models/vend_history_model.dart';
import 'package:visualvend/screens/qrcode/qr_scan_screen.dart';
import 'package:visualvend/screens/vendHistory/vend_history_set_screen.dart';
import 'package:visualvend/screens/vendHistory/all_history_screen.dart';
import 'package:visualvend/screens/vendHistory/view_history_screen.dart';
import 'package:visualvend/services/navigator_service.dart';
import 'package:visualvend/utils/app_utils.dart';
import 'package:visualvend/utils/params.dart';
import 'package:visualvend/utils/sharedpref.dart';

class VendHistoryScreen extends StatefulWidget {
  final Function(int) onClickBackHome;

  VendHistoryScreen({Key key, @required this.onClickBackHome}) : super(key: key);

  @override
  _VendHistoryScreenState createState() => _VendHistoryScreenState();
}

class _VendHistoryScreenState extends State<VendHistoryScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  int pageIndex = 0;
  VendHistory vendHistory;
  List<MenuOptionModel> historyMenus = <MenuOptionModel>[];

  getWindows() {
    switch(pageIndex){
      case 0:
        return AllVendHistoryScreen(onClickHistory: (history){
          vendHistory = history;
          checkHistoryMenus();
        },
        );
      case 1:
        return ViewVendHistorySetScreen(history: vendHistory, onSave: (_historyMenus){
            setState(() {
              historyMenus.clear();
              historyMenus = _historyMenus;
              pageIndex = 2;
            });
          },
        );
      case 2:
        return ViewVendHistoryScreen(history: vendHistory, historyMenus: historyMenus, resetMenu: (){
            setState(() {
              pageIndex = 1;
            });
          }, onClickMenu: (menuIndex){
            if(menuIndex == 1){
              showBanner(context, scaffoldKey, vendRequestToastData[0]['title'], vendRequestToastData[0]['type'], (){
                NavigatorService(context).pushToWidget(screen: QrCodeScreen(startFrgIndex: 1, canGoToProductMenu: true, onClickBackHome: widget.onClickBackHome,));
              });
            }else if(menuIndex == 2){
              showToast('Success to add this machine to favorite .');
            }
          },
        );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: getWindows(),
    );
  }

  bool checkHistoryMenus() {
    historyMenus.clear();
    List<String> titles = <String>[];
    titles.add(SharedPrefs.KEY_VEND_HISTORY_LAST_RECEIPTS);
    titles.add(SharedPrefs.KEY_VEND_HISTORY_ORDER_ITEM);
    titles.add(SharedPrefs.KEY_VEND_HISTORY_ITEM_FAVORITES);

    for(String _title in titles){
      MenuOptionModel model = SharedPrefs.getMenuOption(_title);
      if(model.title != ''){
        historyMenus.add(model);
      }
    }
    if(historyMenus.length > 0){
      setState(() {
        pageIndex = 2;
      });
    }else{
      setState(() {
        pageIndex = 1;
      });
    }
    return false;
  }
}



