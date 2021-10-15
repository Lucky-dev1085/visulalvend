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


class FavoritesSetScreen extends StatefulWidget {
  final Function(List<MenuOptionModel>) onSave;

  const FavoritesSetScreen({Key key, this.onSave, }) : super(key: key);

  @override
  _FavoritesSetScreenState createState() => _FavoritesSetScreenState();
}

class _FavoritesSetScreenState extends State<FavoritesSetScreen> {
  var isRemember = false;
  List<MenuOptionModel> favoriteMenus = <MenuOptionModel>[];

  @override
  void initState() {
    super.initState();
    initFavoriteMenus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: darkGreyColor,
      padding: EdgeInsets.only(left: offsetBase, right: offsetBase, top: offsetBase, bottom: offsetSm),
      child: Column(
        children: [
          SizedBox(height: 12,),
          Text(
            'FAVORITE SETTINGS',
            style: boldText.copyWith(fontSize: font24Lg, color: Colors.white),
          ),
          if(favoriteMenus.length > 0)Expanded(child: Column(
            children: [
              Spacer(),
              for(int i=0; i<favoriteMenus.length; i++)
                InkWell(
                  child: Container(
                    margin: EdgeInsets.only(top: 32),
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    height: 56,
                    child: Row(
                      children: [
                        IconWidget(
                          icon: favoriteMenus.elementAt(i).assetIcon,
                          iconType: ICONTYPE.Svg,
                          color: Colors.white,
                          size: 44,
                        ),
                        Container(width: 6,),
                        favoriteMenus.elementAt(i).isHide ? IconWidget(
                          icon: 'assets/icons/ic_close_box.svg',
                          iconType: ICONTYPE.Svg,
                          color: Colors.white,
                        )
                        : Icon(
                          Icons.check_box_outline_blank,
                          color: Colors.white,
                        ),
                        Container(width: 8,),
                        Text(
                          favoriteMenus.elementAt(i).title,
                          style: boldText.copyWith(fontSize: fontLg, color: Colors.white),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(offsetSm)),
                      color: normalGreyColor,
                    ),
                  ),
                  onTap: (){
                    setState(() {
                      favoriteMenus.elementAt(i).isHide = !favoriteMenus.elementAt(i).isHide;
                      isRemember = false;
                      for (int i = 0; i < favoriteMenus.length; i++){
                        if(favoriteMenus.elementAt(i).isHide){
                          isRemember = true;
                        }
                      }
                    });
                  },
                ),
              Spacer(),
              ],
            ),
          ),
          SizedBox(
            height: offsetBase,
          ),
          InkWell(
            onTap: () {
              setState(() {
                isRemember = !isRemember;
                if(isRemember == false){
                  for (int i = 0; i < favoriteMenus.length; i++){
                    favoriteMenus.elementAt(i).isHide = false;
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
          SizedBox(
            height: offsetMd,
          ),
          InkWell(
            onTap: () => {
              onSaveMenus()
            },
            child: Container(
              width: 120, height: 36,
              child: Text(
                'Save',
                style: semiBold.copyWith(fontSize: fontMd, color: Colors.white),
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.white, width: 1
                ),
                borderRadius: BorderRadius.all(Radius.circular(offsetXSm)),
              ),
            ),
          ),
          SizedBox(height: 12,),
        ],
      ),
    );
  }

  void initFavoriteMenus() {
    favoriteMenus.clear();
    for(int i = 0; i < 2; i++){
      MenuOptionModel model = new MenuOptionModel();
      switch(i){
        case 0:
          model.title = VEND_FAVORITE_MMACHINES_TITLE;
          model.assetIcon = VEND_FAVORITE_MMACHINES_ASSET;
          break;
        case 1:
          model.title = VEND_FAVORITE_PRODUCTS_TITLE;
          model.assetIcon = VEND_FAVORITE_PRODUCTS_ASSET;
          break;
      }
      model.isHide = false;
      favoriteMenus.add(model);
    }
    setState(() {});
  }

  onSaveMenus() {
    List<MenuOptionModel> tmpArr = new List<MenuOptionModel>();
    for(MenuOptionModel model in favoriteMenus){
      if(model.isHide == false){
        if(model.title == VEND_FAVORITE_MMACHINES_TITLE){
          SharedPrefs.setMenuOption(SharedPrefs.KEY_VEND_FAVORITE_MACHINE, model);
        }
        else if(model.title == VEND_FAVORITE_PRODUCTS_TITLE){
          SharedPrefs.setMenuOption(SharedPrefs.KEY_VEND_FAVORITE_PRODUCT, model);
        }
        tmpArr.add(model);
      }
    }
    if(tmpArr.length == 0){
      showToast('Please select at least one menu.');
    }else{
      widget.onSave(tmpArr);
    }
  }
}

