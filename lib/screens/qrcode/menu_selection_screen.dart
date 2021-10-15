import 'package:flutter/material.dart';
import 'package:visualvend/models/menu_option_model.dart';
import 'package:visualvend/utils/app_utils.dart';
import 'package:visualvend/utils/colors.dart';
import 'package:visualvend/utils/constants.dart';
import 'package:visualvend/utils/dimens.dart';
import 'package:visualvend/utils/params.dart';
import 'package:visualvend/utils/sharedpref.dart';
import 'package:visualvend/utils/themes.dart';
import 'package:visualvend/widgets/image_widget.dart';

class MenuSelectionScreen extends StatefulWidget {
  final Function(List<MenuOptionModel>) onSaveMenuSelection;

  const MenuSelectionScreen({
    Key key,
    this.onSaveMenuSelection,
  }) : super(key: key);

  @override
  _MenuSelectionScreenState createState() => _MenuSelectionScreenState();
}

class _MenuSelectionScreenState extends State<MenuSelectionScreen> {
  var isRemember = false;
  List<MenuOptionModel> menuOptions = new List<MenuOptionModel>();

  @override
  void initState() {
    super.initState();
    initProductMenus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: offsetBase, vertical: offsetMd),
      child: Column(
        children: [
          Text(
            'CONNECT TO SITE 12',
            style: boldText.copyWith(fontSize: fontXLg, color: selectedColor),
          ),
          SizedBox(
            height: offsetBase,
          ),
          Text(
            'Westfields Mail Chatswood Level 3',
            style: boldText.copyWith(fontSize: fontLg, color: Colors.white),
          ),
          SizedBox(
            height: offsetMd,
          ),
          Text(
            'SELECT PREFERRED MENUS TO DISPLAY',
            style: boldText.copyWith(fontSize: fontBase, color: Colors.white),
          ),
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: offsetLg,
                ),
                SizedBox(height: 32,),
                if(menuOptions.length > 0)
                for (int i=0; i < menuOptions.length; i++)
                  InkWell(
                    child: Container(
                      height: 54.0,
                      margin: EdgeInsets.only(top: offsetXMd),
                      padding: EdgeInsets.symmetric(horizontal: offsetBaseSm),
                      decoration: BoxDecoration(
                        color: normalGreyColor,
                        borderRadius: BorderRadius.all(Radius.circular(offsetSm)),
                      ),
                      child: Row(
                        children: [
                          IconWidget(
                            icon: menuOptions.elementAt(i).assetIcon,
                            iconType: ICONTYPE.Svg,
                            color: Colors.white,
                            size: i < 2 ? 38 : 32,
                          ),
                          menuOptions.elementAt(i).isHide ? IconWidget(
                            icon: 'assets/icons/ic_close_box.svg',
                            iconType: ICONTYPE.Svg,
                            color: Colors.white,
                          )
                          : Icon(
                            Icons.check_box_outline_blank,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: offsetSm,
                          ),
                          Text(
                            menuOptions.elementAt(i).title,
                            style: boldText.copyWith(fontSize: fontMMd, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    onTap: ()=>{
                      setState(() {
                        menuOptions.elementAt(i).isHide = !menuOptions.elementAt(i).isHide;
                        isRemember = false;
                        for (int i = 0; i < menuOptions.length; i++){
                          if(menuOptions.elementAt(i).isHide){
                            isRemember = true;
                          }
                        }
                      })
                    },
                  ),
              ],
            )
          ),
          InkWell(
            onTap: () {
              setState(() {
                isRemember = !isRemember;
                if(!isRemember){
                  for (int i = 0; i < menuOptions.length; i++){
                    menuOptions.elementAt(i).isHide = false;
                  }
                }
              });
            },
            child: Row(
              children: [
                Icon(
                  isRemember ? Icons.check_box : Icons.check_box_outline_blank,
                  color: Colors.white,
                ),
                SizedBox(
                  width: offsetBase,
                ),
                Text(
                  'Remember menu selection for future',
                  style: semiBold.copyWith(fontSize: fontBase, color: Colors.white),
                ),
              ],
            ),
          ),
          SizedBox(height: offsetMd, ),
          InkWell(
            onTap: () => {
              onSaveSelection(),
            },
            child: Container(
              width: 120, height: 36,
              child: Text('Save', style: semiBold.copyWith(fontSize: fontMd, color: Colors.white), ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white, width: 1
                ),
                borderRadius: BorderRadius.all(Radius.circular(offsetXSm)),
              ),
            ),
          ),
          SizedBox(height: offsetBaseSm, ),
        ],
      ),
    );
  }

  void hideMenuOptionsInSharedPref(List<int> removeArr) {
    MenuOptionModel menu = new MenuOptionModel();
    if(removeArr[0] == 1)
      SharedPrefs.setMenuOption(SharedPrefs.KEY_VEND_PRODUCT_MENU, menu);
    if(removeArr[1] == 1)
      SharedPrefs.setMenuOption(SharedPrefs.KEY_VEND_PRODUCT_LAYOUT, menu);
    if(removeArr[2] == 1)
      SharedPrefs.setMenuOption(SharedPrefs.KEY_VEND_PRODUCT_KEYPAD, menu);
  }

  onSaveSelection() {
    var removeArr = [1, 1, 1, ];
    List<MenuOptionModel> tmpArr = new List<MenuOptionModel>();
    for(MenuOptionModel model in menuOptions){
      if(model.isHide == false){
        if(model.title == VEND_PRODUCT_MENU_TITLE){
          removeArr[0] = 0;
          SharedPrefs.setMenuOption(SharedPrefs.KEY_VEND_PRODUCT_MENU, model);
        }
        else if(model.title == VEND_MACHINE_LAYOUT_TITLE){
          removeArr[1] = 0;
          SharedPrefs.setMenuOption(SharedPrefs.KEY_VEND_PRODUCT_LAYOUT, model);
        }
        else if(model.title == VEND_MAKE_KEYBOARD_SELECTION_TITLE){
          removeArr[2] = 0;
          SharedPrefs.setMenuOption(SharedPrefs.KEY_VEND_PRODUCT_KEYPAD, model);
        }
        tmpArr.add(model);
      }
    }
    if(tmpArr.length > 0){
      hideMenuOptionsInSharedPref(removeArr);
      widget.onSaveMenuSelection(tmpArr);
    }else{
      showToast('Please select at least one menu.');
    }
  }

  void initProductMenus() {
    menuOptions.clear();
    for(int i = 0; i < 3; i++){
      MenuOptionModel model = new MenuOptionModel();
      switch(i){
        case 0:
          model.title = VEND_PRODUCT_MENU_TITLE;
          model.assetIcon = VEND_PRODUCT_MENU_ASSET;
          break;
        case 1:
          model.title = VEND_MACHINE_LAYOUT_TITLE;
          model.assetIcon = VEND_MACHINE_LAYOUT_ASSET;
          break;
        case 2:
          model.title = VEND_MAKE_KEYBOARD_SELECTION_TITLE;
          model.assetIcon = VEND_MAKE_KEYBOARD_SELECTION_ASSET;
          break;
      }
      model.isHide = false;
      menuOptions.add(model);
    }
    setState(() {});
  }
}
