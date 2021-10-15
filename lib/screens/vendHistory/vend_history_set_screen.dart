
import 'package:flutter/material.dart';
import 'package:visualvend/models/menu_option_model.dart';
import 'package:visualvend/models/vend_history_model.dart';
import 'package:visualvend/utils/app_utils.dart';
import 'package:visualvend/utils/colors.dart';
import 'package:visualvend/utils/constants.dart';
import 'package:visualvend/utils/dimens.dart';
import 'package:visualvend/utils/params.dart';
import 'package:visualvend/utils/sharedpref.dart';
import 'package:visualvend/utils/themes.dart';
import 'package:visualvend/widgets/image_widget.dart';


class ViewVendHistorySetScreen extends StatefulWidget {
  final VendHistory history;
  final Function(List<MenuOptionModel>) onSave;

  const ViewVendHistorySetScreen({Key key, this.onSave, this.history, }) : super(key: key);

  @override
  _ViewVendHistorySetScreenState createState() => _ViewVendHistorySetScreenState();
}

class _ViewVendHistorySetScreenState extends State<ViewVendHistorySetScreen> {
  var isRemember = false;
  List<MenuOptionModel> historyMenus = new List<MenuOptionModel>();

  @override
  void initState() {
    super.initState();
    initHistoryMenus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: darkGreyColor,
      padding: EdgeInsets.only(left: offsetBase, right: offsetBase, top: offsetBase, bottom: offsetSm),
      child: Column(
        children: [
          if(widget.history != null) Row(
            children: [
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
          if(historyMenus.length > 0) Expanded(
            child: Column(
            children: [
              for(int i=0; i<historyMenus.length; i++) InkWell(
                  child: Container(
                    margin: EdgeInsets.only(top: 24),
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    height: 56,
                    child: Row(
                      children: [
                        IconWidget(
                          icon: historyMenus.elementAt(i).assetIcon,
                          iconType: ICONTYPE.Svg,
                          color: Colors.white,
                          size: 44,
                        ),
                        Container(width: 6,),
                        historyMenus.elementAt(i).isHide ? IconWidget(
                          icon: 'assets/icons/ic_close_box.svg',
                          iconType: ICONTYPE.Svg,
                          color: Colors.white,
                        ) :
                        Icon(
                          Icons.check_box_outline_blank,
                          color: Colors.white,
                        ),
                        Container(width: 8,),
                        Text(
                          historyMenus.elementAt(i).title,
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
                      historyMenus.elementAt(i).isHide = !historyMenus.elementAt(i).isHide;
                      isRemember = false;
                      for (int i = 0; i < historyMenus.length; i++){
                        if(historyMenus.elementAt(i).isHide){
                          isRemember = true;
                        }
                      }
                    });
                  },
                )
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
                  for (int i = 0; i < historyMenus.length; i++){
                    historyMenus.elementAt(i).isHide = false;
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

  void initHistoryMenus() {
    historyMenus.clear();
    for(int i = 0; i < 3; i++){
      MenuOptionModel model = new MenuOptionModel();
      switch(i){
        case 0:
          model.title = VEND_HISTORY_LAST_RECEIPTS_TITLE;
          model.assetIcon = VEND_HISTORY_LAST_RECEIPTS_ASSET;
          break;
        case 1:
          model.title = VEND_HISTORY_ORDER_ITEM_TITLE;
          model.assetIcon = VEND_HISTORY_ORDER_ITEM_ASSET;
          break;
        case 2:
          model.title = VEND_HISTORY_ITEM_FAVORITES_TITLE;
          model.assetIcon = VEND_HISTORY_ITEM_FAVORITES_ASSET;
          break;
      }
      model.isHide = false;
      historyMenus.add(model);
    }
    setState(() {});
  }

  onSaveMenus() {
    List<MenuOptionModel> tmpArr = new List<MenuOptionModel>();
    for(MenuOptionModel model in historyMenus){
      if(model.isHide == false){
        if(model.title == VEND_HISTORY_LAST_RECEIPTS_TITLE){
          SharedPrefs.setMenuOption(SharedPrefs.KEY_VEND_HISTORY_LAST_RECEIPTS, model);
        }
        else if(model.title == VEND_HISTORY_ORDER_ITEM_TITLE){
          SharedPrefs.setMenuOption(SharedPrefs.KEY_VEND_HISTORY_ORDER_ITEM, model);
        }
        else if(model.title == VEND_HISTORY_ITEM_FAVORITES_TITLE){
          SharedPrefs.setMenuOption(SharedPrefs.KEY_VEND_HISTORY_ITEM_FAVORITES, model);
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

