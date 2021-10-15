import 'package:flutter/material.dart';
import 'package:visualvend/utils/colors.dart';
import 'package:visualvend/utils/constants.dart';
import 'package:visualvend/utils/dimens.dart';
import 'package:visualvend/utils/params.dart';
import 'package:visualvend/utils/themes.dart';
import 'package:visualvend/widgets/image_widget.dart';

class ProductCategoriesScreen extends StatefulWidget {
  final Function(dynamic) onClickCategory;
  final Function onClickProductLayout;
  final Function onClickManualMachine;

  const ProductCategoriesScreen({
    Key key,
    @required this.onClickCategory,
    this.onClickProductLayout,
    this.onClickManualMachine
  }) : super(key: key);

  @override
  _ProductCategoriesScreenState createState() => _ProductCategoriesScreenState();
}

class _ProductCategoriesScreenState extends State<ProductCategoriesScreen> {
  var isRemember = false;

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
            height: offsetMd,
          ),
          Text(
            'SELECT PREFERRED MENUS TO DISPLAY',
            style: boldText.copyWith(fontSize: fontBase, color: Colors.white),
          ),
          SizedBox(
            height: offsetLg,
          ),
          Row(
            children: [
              InkWell(
                child: IconWidget(
                  icon: 'assets/icons/ic_view_product.svg',
                  iconType: ICONTYPE.Svg,
                  color: Colors.white,
                  size: 44.0,
                ),
                onTap: (){
                  widget.onClickProductLayout();
                },
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
                child: IconWidget(
                  icon: 'assets/icons/ic_manul.svg',
                  iconType: ICONTYPE.Svg,
                  color: Colors.white,
                  size: 32.0,
                ),
                onTap: (){
                  widget.onClickManualMachine();
                },
              ),
            ],
          ),
          SizedBox(
            height: offsetBase,
          ),
          Expanded(
            child: GridView.count(
              shrinkWrap: true,
              padding: EdgeInsets.all(offsetSm),
              crossAxisCount: 2,
              childAspectRatio: 2,
              children: [
                for (var item in categoryData) InkWell(
                  onTap: () => widget.onClickCategory(item),
                  child: Container(
                    margin: EdgeInsets.all(offsetSm),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(offsetSm)),
                      color: normalGreyColor,
                    ),
                    child: Center(
                      child: Text(
                        item.toUpperCase(),
                        style: boldText.copyWith(fontSize: fontLg, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ),
          SizedBox(
            height: offsetBase,
          ),
          InkWell(
            onTap: () {
              setState(() {
                isRemember = !isRemember;
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
            height: offsetBase,
          ),
        ],
      ),
    );
  }
}
