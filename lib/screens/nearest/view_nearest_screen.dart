import 'package:flutter/material.dart';
import 'package:visualvend/models/menu_option_model.dart';
import 'package:visualvend/models/vend_machine_model.dart';
import 'package:visualvend/utils/colors.dart';
import 'package:visualvend/utils/constants.dart';
import 'package:visualvend/utils/dimens.dart';
import 'package:visualvend/utils/themes.dart';
import 'package:visualvend/widgets/image_widget.dart';


class ViewNearestScreen extends StatefulWidget {
  final VendMachine machine;
  final List<MenuOptionModel> machineMenus;
  final Function resetMenu;
  final Function(MenuOptionModel) onClickMenu;

  const ViewNearestScreen({Key key, this.onClickMenu, this.machineMenus, this.machine, this.resetMenu, }) : super(key: key);

  @override
  _ViewNearestScreenState createState() => _ViewNearestScreenState();
}

class _ViewNearestScreenState extends State<ViewNearestScreen> {
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
          if(widget.machine != null) Row(
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
          if(widget.machineMenus.length > 0)Expanded(child: Column(
            children: [
              for(int i = 0; i<widget.machineMenus.length; i++)
                if(!widget.machineMenus.elementAt(i).isHide)InkWell(
                  child: Container(
                    margin: EdgeInsets.only(top: 24),
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    height: 56,
                    child: Row(
                      children: [
                        IconWidget(
                          icon: widget.machineMenus.elementAt(i).assetIcon,
                          iconType: ICONTYPE.Svg,
                          color: Colors.white,
                          size: i == 2 ? 34 : 44,
                        ),
                        Container(width: offsetBaseSm,),
                        Text(
                          widget.machineMenus.elementAt(i).title,
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
                    widget.onClickMenu(widget.machineMenus.elementAt(i));
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
              widget.resetMenu();
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
        ],
      ),
    );
  }
}

