import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visualvend/models/menu_option_model.dart';
import 'package:visualvend/models/vend_history_model.dart';
import 'package:visualvend/screens/chats/contact_us_screen.dart';
import 'package:visualvend/screens/chats/messaging_screen.dart';
import 'package:visualvend/screens/favorites/favorite_main_screen.dart';
import 'package:visualvend/screens/favorites/favorite_set_screen.dart';
import 'package:visualvend/screens/search/search_screen.dart';
import 'package:visualvend/screens/vendHistory/all_history_screen.dart';
import 'package:visualvend/screens/vendHistory/view_history_screen.dart';
import 'package:visualvend/screens/vendmenu/vend_menu.dart';
import 'package:visualvend/services/navigator_service.dart';
import 'package:visualvend/utils/app_utils.dart';
import 'package:visualvend/utils/colors.dart';
import 'package:visualvend/utils/constants.dart';
import 'package:visualvend/utils/dimens.dart';
import 'package:visualvend/utils/params.dart';
import 'package:visualvend/utils/sharedpref.dart';
import 'package:visualvend/utils/themes.dart';

class FavoriteScreen extends StatefulWidget {
  final Function(int) onClickBackHome;
  FavoriteScreen({Key key, this.onClickBackHome}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  var pageIndex = 0;
  List<MenuOptionModel> favoriteMenus = <MenuOptionModel>[];

  getWindows(){
    switch(pageIndex){
      case 0:
        return FavoriteMainScreen(
          favoriteMenus: favoriteMenus,
          onClickMenu: (_index){
            onClickMenuItem(_index);
          },
          onChangeRemember: (){
            setState(() {
              pageIndex = 1;
            });
          },
        );
      case 1:
        return FavoritesSetScreen(
          onSave: (_favorites){
              favoriteMenus.clear();
              favoriteMenus = _favorites;
              setState(() {
                pageIndex = 0;
              });
            },
          );
      case 2:
        return SearchScreen(title: 'Favorite Products', willPopUpProduct: false, searchCategory: '', searchKey: '',
          onclickBack: (){
            setState(() {
              pageIndex = 0;
            });
          },
        );
      case 3:
        return VendMenuScreen(title: 'Favorite Machines', scaffoldKey: scaffoldKey, onCallback: (){
            setState(() {
              pageIndex = 0;
            });
          },
          onClickBackHome: (_index){
            widget.onClickBackHome(_index);
          },
        );
    }
  }

  @override
  void initState() {
    checkSavedFavoriteOptions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: getWindows(),
    );
  }

  void checkSavedFavoriteOptions() {
    favoriteMenus.clear();
    MenuOptionModel model = SharedPrefs.getMenuOption(SharedPrefs.KEY_VEND_FAVORITE_MACHINE);
    if(model.title != '' && !model.isHide){
      favoriteMenus.add(model);
    }
    MenuOptionModel model1 = SharedPrefs.getMenuOption(SharedPrefs.KEY_VEND_FAVORITE_PRODUCT);
    if(model1.title != '' && !model1.isHide){
      favoriteMenus.add(model1);
    }

    if(favoriteMenus.length == 0){
      setState(() {
        pageIndex = 1;
      });
    }else{
      setState(() {
        pageIndex = 0;
      });
    }
  }

  void onClickMenuItem(int index) {
    if(index == 1){
      showBanner(context, scaffoldKey, vendRequestToastData[0]['title'], vendRequestToastData[0]['type'], (){
        setState(() {
          pageIndex = 2;
        });
      });
    }else if(index == 0){
      setState(() {
        pageIndex = 3;
      });
    }
  }
}



