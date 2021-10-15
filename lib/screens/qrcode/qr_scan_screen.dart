import 'package:flutter/material.dart';
import 'package:visualvend/models/menu_option_model.dart';
import 'package:visualvend/screens/main/favorite_screen.dart';
import 'package:visualvend/screens/qrcode/machine_qr_input_screen.dart';
import 'package:visualvend/screens/qrcode/product_categories_screen.dart';
import 'package:visualvend/screens/qrcode/menu_selection_screen.dart';
import 'package:visualvend/screens/qrcode/products_in_category_screen.dart';
import 'package:visualvend/screens/qrcode/product_layout_screen.dart';
import 'package:visualvend/screens/qrcode/manual_input_screen.dart';
import 'package:visualvend/screens/qrcode/manual_marchine_screen.dart';
import 'package:visualvend/screens/qrcode/product_chat_screen.dart';
import 'package:visualvend/utils/colors.dart';
import 'package:visualvend/utils/params.dart';
import 'package:visualvend/utils/sharedpref.dart';
import 'package:visualvend/utils/themes.dart';
import 'package:visualvend/widgets/image_widget.dart';

import 'machine_main_menu_screen.dart';

class QrCodeScreen extends StatefulWidget {
  final int startFrgIndex;
  final bool canGoToProductMenu;
  final Function(String) onbackWithCode;
  final Function(int) onClickBackHome;

  const QrCodeScreen({Key key, this.startFrgIndex, @required this.onClickBackHome, @required this.canGoToProductMenu, this.onbackWithCode,}) : super(key: key);
  @override
  _QrCodeScreenState createState() => _QrCodeScreenState();
}

enum QRSCREENTYPE {
  MachineQRInput,
  ManualInput,
  MenuSelection,
  MachineMainMenus,
  ProductCategories,
  ProductsInCategory,
  ProductLayout,
  ManualMachine,
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  List<MenuOptionModel> productMenus = <MenuOptionModel>[];

  var screenType = QRSCREENTYPE.MachineQRInput;
  var pageIndex = 1;

  _getWidget() {
    switch (screenType) {
      case QRSCREENTYPE.MachineQRInput:
        return MachineQRInputScreen(
          onClickManualInput: () {
            setState(() {
              screenType = QRSCREENTYPE.ManualInput;
            });
          },
          onConnectToMachine: (code) {
            if(widget.canGoToProductMenu){
              setState(() {
                checkMachineStatus();
              });
            }else{
              // widget.onbackWithCode(code);
              widget.onbackWithCode('12345');
              Navigator.of(context).pop();
            }
          },
        );
      case QRSCREENTYPE.ManualInput:
        return ManualInputScreen(
          onClickQRScan: () {
            setState(() {
              screenType = QRSCREENTYPE.MachineQRInput;
            });
          },
          onClickOkKeypad: (code){
            setState(() {
              if(widget.canGoToProductMenu){
                setState(() {
                  checkMachineStatus();
                });
              }else{
                widget.onbackWithCode(code);
                Navigator.of(context).pop();
              }
            });
          },
        );
      case QRSCREENTYPE.MenuSelection:
        return MenuSelectionScreen(
          onSaveMenuSelection: (_productMenus) {
            productMenus.clear();
            productMenus = _productMenus;
            setState(() {
              screenType = QRSCREENTYPE.MachineMainMenus;
            });
          },
        );
      case QRSCREENTYPE.MachineMainMenus:
        return MachineMainMenuScreen(
          savedMenus: productMenus,
          resetMenu: () {
            setState(() {
              screenType = QRSCREENTYPE.MenuSelection;
            });
          },
          onClickManualMachine: () {
            setState(() {
              screenType = QRSCREENTYPE.ManualMachine;
            });
          },
          onClickMachineLayout: () {
            setState(() {
              screenType = QRSCREENTYPE.ProductLayout;
            });
          },
          onClickProductMenu: () {
            setState(() {
              screenType = QRSCREENTYPE.ProductCategories;
            });
          },
        );
      case QRSCREENTYPE.ProductCategories:
        return ProductCategoriesScreen(
          onClickCategory: (item) {
            setState(() {
              screenType = QRSCREENTYPE.ProductsInCategory;
            });
          },
          onClickProductLayout: (){
            setState(() {
              screenType = QRSCREENTYPE.ProductLayout;
            });
          },
          onClickManualMachine: (){
            setState(() {
              screenType = QRSCREENTYPE.ManualMachine;
            });
          },
        );
      case QRSCREENTYPE.ProductsInCategory:
        return ProductsInCategoryScreen(
          scaffoldKey: scaffoldKey,
          onClickManualMachine: () {
            setState(() {
              screenType = QRSCREENTYPE.ManualMachine;
            });
          },
          onClickViewCategory: (){
            screenType = QRSCREENTYPE.ProductCategories;
          },
          onClickProductLayout: () {
            setState(() {
              screenType = QRSCREENTYPE.ProductLayout;
            });
          },
        );
      case QRSCREENTYPE.ManualMachine:
        return ManualMachineScreen(
          onClickQRInput: () {
            setState(() {
              screenType = QRSCREENTYPE.MachineQRInput;
            });
          },
          onClickProductMenu: (){
            setState(() {
              screenType = QRSCREENTYPE.ProductCategories;
            });
          },
          onClickProductCategory: (){
            setState(() {
              screenType = QRSCREENTYPE.ProductLayout;
            });
          },
        );
      case QRSCREENTYPE.ProductLayout:
        return ProductLayoutScreen(
          scaffoldKey: scaffoldKey,
          onClickManualMachine: () {
            setState(() {
              screenType = QRSCREENTYPE.ManualMachine;
            });
          },
          onClickProductMenu: () {
            setState(() {
              screenType = QRSCREENTYPE.ProductCategories;
            });
          },
        );
    }
  }

  navigationBottomBar(){
    switch(pageIndex){
      case 1:
        return _getWidget();
      case 3:
        return ProductChat();
      case 4:
        return FavoriteScreen(onClickBackHome: (_index){
            widget.onClickBackHome(_index);
          },
        );
    }
  }

  @override
  void initState() {
    super.initState();

    if(widget.startFrgIndex == 1){
      checkMachineStatus();
    }
    else if(widget.startFrgIndex == 2){
      setState(() {
        screenType = QRSCREENTYPE.MenuSelection;
      });
    }
    else if(widget.startFrgIndex == 3){
      setState(() {
        screenType = QRSCREENTYPE.ManualInput;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        backProcess();
        return false;
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: Container(child: Center(child: Text('MEDIA AD PLAYS', style: semiBold.copyWith(fontSize: 18.0),))),
          backgroundColor: Colors.white,
        ),
        body: navigationBottomBar(),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: SizedBox(
            height: 54,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                for (var item in qrBottomItems) Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        if (qrBottomItems.indexOf(item) == 0) {
                          backProcess();
                        }
                        else if (qrBottomItems.indexOf(item) == 2) {
                          Navigator.of(context, rootNavigator: true).pop();
                          widget.onClickBackHome(2);
                        }
                        else if (qrBottomItems.indexOf(item) == 4) {
                          Navigator.of(context, rootNavigator: true).pop();
                          widget.onClickBackHome(0);
                        }
                        else {
                          pageIndex = qrBottomItems.indexOf(item);
                        }
                      });
                    },
                    child: Center(
                      child: item['shape'] == 'Circle' ? CircleIconWidget(
                        iconType: item['type'],
                        icon: item['icon'],
                        size: 42.0,
                        color: Colors.white,
                        background: getFocusColor(qrBottomItems.indexOf(item), pageIndex),
                      ) :
                      IconWidget(
                        iconType: item['type'],
                        icon: item['icon'],
                        size: 42.0,
                        color: getFocusColor(qrBottomItems.indexOf(item), pageIndex),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  checkMachineStatus() {
    productMenus.clear();

    List<String> titles = <String>[];
    titles.add(SharedPrefs.KEY_VEND_PRODUCT_MENU);
    titles.add(SharedPrefs.KEY_VEND_PRODUCT_LAYOUT);
    titles.add(SharedPrefs.KEY_VEND_PRODUCT_KEYPAD);

    for(String _title in titles){
      MenuOptionModel model = SharedPrefs.getMenuOption(_title);
      if(model.title != ''){
        productMenus.add(model);
      }
    }

    if(productMenus.length > 0){
      setState(() {
        screenType = QRSCREENTYPE.MachineMainMenus;
      });
    }else{
      setState(() {
        screenType = QRSCREENTYPE.MenuSelection;
      });
    }
  }

  void backProcess() {
    switch (screenType) {
      case QRSCREENTYPE.MachineQRInput:
        Navigator.of(context).pop();
        break;
      case QRSCREENTYPE.ManualInput:
        Navigator.of(context).pop();
        break;
      case QRSCREENTYPE.MenuSelection:
        Navigator.of(context).pop();
        break;
      case QRSCREENTYPE.MachineMainMenus:
        Navigator.of(context).pop();
        break;
      case QRSCREENTYPE.ProductCategories:
        setState(() {
          screenType = QRSCREENTYPE.MachineMainMenus;
        });
        break;
      case QRSCREENTYPE.ProductsInCategory:
        setState(() {
          screenType = QRSCREENTYPE.MachineMainMenus;
        });
        break;
      case QRSCREENTYPE.ManualMachine:
        setState(() {
          screenType = QRSCREENTYPE.MachineMainMenus;
        });
        break;
      case QRSCREENTYPE.ProductLayout:
        setState(() {
          screenType = QRSCREENTYPE.MachineMainMenus;
        });
        break;
    }
  }
}
