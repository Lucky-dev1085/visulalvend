import 'dart:async';

import 'package:flutter/material.dart';
import 'package:visualvend/models/menu_option_model.dart';
import 'package:visualvend/models/vend_history_model.dart';
import 'package:visualvend/utils/app_utils.dart';
import 'package:visualvend/utils/colors.dart';
import 'package:visualvend/utils/constants.dart';
import 'package:visualvend/utils/dimens.dart';
import 'package:visualvend/utils/sharedpref.dart';
import 'package:visualvend/utils/themes.dart';
import 'package:visualvend/widgets/dropbox_widget.dart';
import 'package:visualvend/widgets/image_widget.dart';
import 'package:visualvend/widgets/textfield_widget.dart';


class FavoriteMainScreen extends StatefulWidget {
  final onChangeRemember;
  final List<MenuOptionModel> favoriteMenus;
  final Function(int) onClickMenu;
  const FavoriteMainScreen({Key key, this.onChangeRemember, this.favoriteMenus, this.onClickMenu, }) : super(key: key);

  @override
  _FavoriteMainScreenState createState() => _FavoriteMainScreenState();
}

class _FavoriteMainScreenState extends State<FavoriteMainScreen> {

  @override
  void initState() {
    super.initState();
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
          if(widget.favoriteMenus.length > 0)Expanded(child: Column(
            children: [
              Spacer(),
              for(int i=0; i<widget.favoriteMenus.length; i++)
                InkWell(
                  child: Container(
                    margin: EdgeInsets.only(top: 32),
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    height: 56,
                    child: Row(
                      children: [
                        IconWidget(
                          icon: widget.favoriteMenus.elementAt(i).assetIcon,
                          iconType: ICONTYPE.Svg,
                          color: Colors.white,
                          size: 44,
                        ),
                        Container(width: 8,),
                        Text(
                          widget.favoriteMenus.elementAt(i).title,
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
                    widget.onClickMenu(i);
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
                widget.onChangeRemember();
              });
            },
            child: Row(
              children: [
                Icon(
                  Icons.check_box,
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
        ],
      ),
    );
  }
}

