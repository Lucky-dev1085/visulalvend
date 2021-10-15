import 'package:flutter/material.dart';
import 'package:visualvend/models/menu_option_model.dart';
import 'package:visualvend/utils/colors.dart';
import 'package:visualvend/utils/constants.dart';
import 'package:visualvend/utils/dimens.dart';
import 'package:visualvend/utils/params.dart';
import 'package:visualvend/utils/themes.dart';
import 'package:visualvend/widgets/image_widget.dart';

class MachineMainMenuScreen extends StatefulWidget {
  final List<MenuOptionModel> savedMenus;
  final Function resetMenu;
  final Function() onClickProductMenu;
  final Function() onClickMachineLayout;
  final Function() onClickManualMachine;

  const MachineMainMenuScreen({
    Key key,
    this.savedMenus,
    this.resetMenu,
    @required this.onClickManualMachine,
    @required this.onClickProductMenu,
    @required this.onClickMachineLayout,
  }) : super(key: key);

  @override
  _MachineMainMenuScreenState createState() => _MachineMainMenuScreenState();
}

enum MachineVendorType {
  MainVendor,
}

class _MachineMainMenuScreenState extends State<MachineMainMenuScreen> {
  var viewMethod = 'default';

  @override
  void initState() {
    super.initState();
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
            height: offsetBase,
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
                Row(
                  children: [
                    InkWell(
                      onTap: () => widget.onClickProductMenu(),
                      child: IconWidget(
                        icon: 'assets/icons/ic_vend_select.svg',
                        iconType: ICONTYPE.Svg,
                        color: Colors.white,
                        size: 32.0,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'MAKE SELECTION OR SEARCH FOR ITEM',
                          style: boldText.copyWith(fontSize: fontSm, color: Colors.white),
                        ),
                      )
                    ),
                    InkWell(
                      onTap: () => widget.onClickManualMachine(),
                      child: IconWidget(
                        icon: 'assets/icons/ic_manul.svg',
                        iconType: ICONTYPE.Svg,
                        color: Colors.white,
                        size: 32.0,
                      ),
                    ),
                  ],
                ),
                for (int i=0; i < widget.savedMenus.length; i++)
                  if(!widget.savedMenus.elementAt(i).isHide) InkWell(
                    onTap: () {
                      if (widget.savedMenus.elementAt(i).title == VEND_PRODUCT_MENU_TITLE) {
                        widget.onClickProductMenu();
                      }
                      else if (widget.savedMenus.elementAt(i).title == VEND_MACHINE_LAYOUT_TITLE) {
                        widget.onClickMachineLayout();
                      }
                      else if (widget.savedMenus.elementAt(i).title == VEND_MAKE_KEYBOARD_SELECTION_TITLE) {
                        widget.onClickManualMachine();
                      }
                    },
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
                            icon: widget.savedMenus.elementAt(i).assetIcon,
                            iconType: ICONTYPE.Svg,
                            color: Colors.white,
                            size: i < 2 ? 38 : 32,
                          ),
                          SizedBox(
                            width: offsetSm,
                          ),
                          Text(
                            widget.savedMenus.elementAt(i).title,
                            style: boldText.copyWith(fontSize: fontMMd, color: Colors.white),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
              ],
            )
          ),
          InkWell(
            onTap: () {
              widget.resetMenu();
            },
            child: Row(
              children: [
                IconWidget(
                  icon: 'assets/icons/ic_close_box.svg',
                  iconType: ICONTYPE.Svg,
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
            height: offsetBase,
          ),
        ],
      ),
    );
  }
}
