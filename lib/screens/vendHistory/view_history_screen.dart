import 'package:flutter/material.dart';
import 'package:visualvend/models/menu_option_model.dart';
import 'package:visualvend/models/vend_history_model.dart';
import 'package:visualvend/utils/colors.dart';
import 'package:visualvend/utils/constants.dart';
import 'package:visualvend/utils/dimens.dart';
import 'package:visualvend/utils/themes.dart';
import 'package:visualvend/widgets/image_widget.dart';

class ViewVendHistoryScreen extends StatefulWidget {
  final VendHistory history;
  final List<MenuOptionModel> historyMenus;
  final Function resetMenu;
  final Function(int) onClickMenu;

  const ViewVendHistoryScreen({Key key, this.onClickMenu, this.historyMenus, this.history, this.resetMenu, }) : super(key: key);

  @override
  _ViewVendHistoryScreenState createState() => _ViewVendHistoryScreenState();
}

class _ViewVendHistoryScreenState extends State<ViewVendHistoryScreen> {
  var isRemember = true;

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
          if(widget.history != null) Row(children: [
              Container(
                margin: EdgeInsets.only(top: 12, left: 12),
                child: Image.asset('assets/icons/ic_vend_machine.png', width: 64,),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.history.vendTitle, style:  semiBold.copyWith(fontSize: fontLg, color: Colors.white),),
                      Padding(
                        padding: const EdgeInsets.only(left: 2, top: 6),
                        child: Text(widget.history.vendItem, style:  semiBold.copyWith(fontSize: fontBase, color: Colors.white),),
                      ),
                    ],
                  ),
                )
              ),
            ],
          ),
          SizedBox(height: 12,),
          if(widget.historyMenus.length > 0)Expanded(child: Column(
              children: [
                for(int i = 0; i<widget.historyMenus.length; i++)
                  if(!widget.historyMenus.elementAt(i).isHide) InkWell(
                    child: Container(
                      margin: EdgeInsets.only(top: 24),
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      height: 56,
                      child: Row(
                        children: [
                          IconWidget(
                            icon: widget.historyMenus.elementAt(i).assetIcon,
                            iconType: ICONTYPE.Svg,
                            color: Colors.white,
                            size: 44,
                          ),
                          Container(width: offsetBaseSm,),
                          Text(
                            widget.historyMenus.elementAt(i).title,
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
                      onClickMenuItem(i);
                    },
                  ),
              ],
            ),
          ),
          SizedBox(
            height: offsetBase,
          ),
          InkWell(
            child: Row(children: [
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
            onTap: () {
              onClickResetMenu();
            },
          ),
          SizedBox(
            height: offsetMd,
          ),
        ],
      ),
    );
  }

  void onClickMenuItem(int i) {
    widget.onClickMenu(i);
  }

  void onClickResetMenu() {
    widget.resetMenu();
  }
}

