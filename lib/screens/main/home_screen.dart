import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visualvend/models/menu_option_model.dart';
import 'package:visualvend/screens/qrcode/qr_scan_screen.dart';
import 'package:visualvend/screens/qrcode/settings_screen.dart';
import 'package:visualvend/screens/vendmenu/vend_menu.dart';
import 'package:visualvend/services/dialog_service.dart';
import 'package:visualvend/services/navigator_service.dart';
import 'package:visualvend/utils/app_utils.dart';
import 'package:visualvend/utils/colors.dart';
import 'package:visualvend/utils/constants.dart';
import 'package:visualvend/utils/dimens.dart';
import 'package:visualvend/utils/params.dart';
import 'package:visualvend/utils/themes.dart';
import 'package:visualvend/widgets/image_widget.dart';

class HomeScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function(int) onClickBackHome;
  final Function onChangeSearchOption;
  HomeScreen({Key key, this.onClickBackHome, this.onChangeSearchOption, this.scaffoldKey}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<MenuOptionModel> productMenus = <MenuOptionModel>[];
  var pageIndex = 0;

  getWindows(){
    switch(pageIndex){
      case 0:
        return HomeScreenWidget(scaffoldKey: widget.scaffoldKey, onClickBackHome: (_index){
            widget.onClickBackHome(_index);
          },
          onClickSettings: (){
            setState(() {
              pageIndex = 1;
            });
          },
          onClickVendMenu: (){
            setState(() {
              pageIndex = 2;
            });
          },
        );
      case 1:
        return SettingsScreen(onCallback: (){
            setState(() {
              pageIndex = 0;
            });
          },
          onChangeSearchOption: widget.onChangeSearchOption,
        );
      case 2:
        return VendMenuScreen(title: 'All Machines', scaffoldKey: widget.scaffoldKey, onCallback: (){
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
  Widget build(BuildContext context) {
    return getWindows();
  }
}

class HomeScreenWidget extends StatelessWidget{
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function(int) onClickBackHome;
  final Function onClickSettings;
  final Function onClickVendMenu;

  const HomeScreenWidget({Key key, this.onClickBackHome, this.onClickSettings, this.scaffoldKey, this.onClickVendMenu, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: offsetXSm,),
        Expanded(child: Container(
          padding: EdgeInsets.all(offsetBase),
          child: Column(children: [
              Spacer(),
              Row(children: [
                  SelectOptionWidget(
                    icon: homeMenus[0]['icon'],
                    title: homeMenus[0]['title'],
                    type: homeMenus[0]['type'],
                    onClick: () {
                      NavigatorService(context).pushToWidget(screen: QrCodeScreen(startFrgIndex: 0, canGoToProductMenu: true, onClickBackHome: (index){
                          onClickBackHome(index);
                        },
                      ));
                    },
                  ),
                  SizedBox(width: offsetBaseSm,),
                  SelectOptionWidget(
                    icon: homeMenus[1]['icon'],
                    title: homeMenus[1]['title'],
                    type: homeMenus[1]['type'],
                    onClick: () {
                      onClickVendMenu();
                    },
                  ),
                ],
              ),
              SizedBox(height: offsetBaseSm,),
              Row(children: [
                  SelectOptionWidget(
                    icon: homeMenus[2]['icon'],
                    title: homeMenus[2]['title'],
                    type: homeMenus[2]['type'],
                    onClick: () {
                      onClickBackHome(1);
                    },
                  ),
                  SizedBox(width: offsetBaseSm,),
                  SelectOptionWidget(
                    icon: homeMenus[3]['icon'],
                    title: homeMenus[3]['title'],
                    type: homeMenus[3]['type'],
                    onClick: (){
                      onClickSettings();
                    },
                  ),
                ],
              ),
              Spacer(),
            ],
          ),
        )),
      ],
    );
  }


}

class SelectOptionWidget extends StatelessWidget {
  final dynamic icon;
  final String title;
  final ICONTYPE type;
  final Function() onClick;

  const SelectOptionWidget({Key key, @required this.icon, @required this.title, @required this.type, this.onClick,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: InkWell(
        onTap: () => onClick(),
        child: Container(
          height: 186,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(offsetXMd)),
            color: darkGreyColor,
          ),
          child: Column(children: [
              Spacer(),
              IconWidget(
                icon: icon,
                iconType: type,
                size: 78.0,
                color: Colors.white,
              ),
              SizedBox(height: offsetMd,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: offsetBase),
                child: Text(title.toUpperCase(),
                  style: boldText.copyWith(fontSize: fontMMd, color: Colors.white,),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      )
    );
  }
}

