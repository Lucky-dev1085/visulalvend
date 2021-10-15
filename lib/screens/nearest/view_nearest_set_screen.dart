import 'package:flutter/material.dart';
import 'package:visualvend/models/menu_option_model.dart';
import 'package:visualvend/models/vend_machine_model.dart';
import 'package:visualvend/utils/app_utils.dart';
import 'package:visualvend/utils/colors.dart';
import 'package:visualvend/utils/constants.dart';
import 'package:visualvend/utils/dimens.dart';
import 'package:visualvend/utils/params.dart';
import 'package:visualvend/utils/sharedpref.dart';
import 'package:visualvend/utils/themes.dart';
import 'package:visualvend/widgets/image_widget.dart';

class ViewNearestSetScreen extends StatefulWidget {
  final VendMachine machine;
  final Function(List<MenuOptionModel>) onSave;

  const ViewNearestSetScreen({Key key, this.onSave, this.machine, }) : super(key: key);

  @override
  _ViewNearestSetScreenState createState() => _ViewNearestSetScreenState();
}

class _ViewNearestSetScreenState extends State<ViewNearestSetScreen> {
  var isRemember = false;
  List<MenuOptionModel> machineMenus = <MenuOptionModel>[];

  @override
  void initState() {
    super.initState();
    initMachineMenus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: darkGreyColor,
      padding: EdgeInsets.only(left: offsetBase, right: offsetBase, top: offsetBase, bottom: offsetSm),
      child: Column(
        children: [
          if(widget.machine != null)Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 12, left: 12),
                child: Image.asset('assets/icons/ic_vend_machine.png', width: 64,),
              ),
              Expanded(child: Container(
                margin: EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.machine.location, style:  semiBold.copyWith(fontSize: fontLg, color: Colors.white),),
                      Padding(
                        padding: const EdgeInsets.only(left: 2, top: 6),
                        child: Text(widget.machine.site, style:  semiBold.copyWith(fontSize: fontBase, color: Colors.white),),
                      ),
                    ],
                  ),
                )
              ),
            ],
          ),
          SizedBox(height: 12,),
          if(machineMenus.length > 0)Expanded(
            child: Column(
              children: [
                for(int i = 0; i < machineMenus.length; i++) InkWell(
                  child: Container(
                    margin: EdgeInsets.only(top: offsetXMd),
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    height: 56,
                    child: Row(
                      children: [
                        IconWidget(
                          icon: machineMenus.elementAt(i).assetIcon,
                          iconType: ICONTYPE.Svg,
                          color: Colors.white,
                          size: i == 2 ? 34 : 44,
                        ),
                        Container(width: 6,),
                        machineMenus.elementAt(i).isHide ? IconWidget(
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
                          machineMenus.elementAt(i).title,
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
                      machineMenus.elementAt(i).isHide = !machineMenus.elementAt(i).isHide;
                      isRemember = false;
                      for (int i = 0; i < machineMenus.length; i++){
                        if(machineMenus.elementAt(i).isHide){
                          isRemember = true;
                        }
                      }
                    });
                  },
                ),
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
                  for (int i = 0; i < machineMenus.length; i++){
                    machineMenus.elementAt(i).isHide = false;
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
              onSaveMachineMenus(),
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

  void initMachineMenus() {
    machineMenus.clear();
    for(int i = 0; i < 3; i++){
      MenuOptionModel model = new MenuOptionModel();
      switch(i){
        case 0:
          model.title = VEND_MACHINE_NEARBY_TITLE;
          model.assetIcon = VEND_MACHINE_NEARBY_ASSET;
          break;
        case 1:
          model.title = VEND_MACHINE_BY_LOCATION_TITLE;
          model.assetIcon = VEND_MACHINE_BY_LOCATION_ASSET;
          break;
        case 2:
          model.title = VEND_MACHINE_FULL_LIST_TITLE;
          model.assetIcon = VEND_MACHINE_FULL_LIST_ASSET;
          break;
      }
      model.isHide = false;
      machineMenus.add(model);
    }
    setState(() {});
  }

  onSaveMachineMenus() {
    List<MenuOptionModel> tmpArr = new List<MenuOptionModel>();
    for(MenuOptionModel model in machineMenus){
      if(model.isHide == false){
        if(model.title == VEND_MACHINE_NEARBY_TITLE){
          SharedPrefs.setMenuOption(SharedPrefs.KEY_VEND_MACHINE_NEARBY, model);
        }
        else if(model.title == VEND_MACHINE_BY_LOCATION_TITLE){
          SharedPrefs.setMenuOption(SharedPrefs.KEY_VEND_MACHINE_BY_LOCATION, model);
        }
        else if(model.title == VEND_MACHINE_FULL_LIST_TITLE){
          SharedPrefs.setMenuOption(SharedPrefs.KEY_VEND_MACHINE_FULL_LIST, model);
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

