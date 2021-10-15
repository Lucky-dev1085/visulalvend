import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visualvend/models/product_model.dart';
import 'package:visualvend/screens/carts/cart_screen.dart';
import 'package:visualvend/screens/product_widgets/products_in_menu_class.dart';
import 'package:visualvend/services/navigator_service.dart';
import 'package:visualvend/utils/colors.dart';
import 'package:visualvend/utils/constants.dart';
import 'package:visualvend/utils/dimens.dart';
import 'package:visualvend/utils/sharedpref.dart';
import 'package:visualvend/utils/themes.dart';
import 'package:visualvend/widgets/image_widget.dart';


class ProductsInCategoryScreen extends StatefulWidget {
  final bool isExpand;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function() onClickManualMachine;
  final Function() onClickViewCategory;
  final Function() onClickProductLayout;

  const ProductsInCategoryScreen({
    Key key,
    this.isExpand = true,
    this.scaffoldKey,
    this.onClickManualMachine,
    this.onClickViewCategory,
    this.onClickProductLayout,
  }) : super(key: key);

  @override
  _ProductsInCategoryScreenState createState() => _ProductsInCategoryScreenState();
}

class _ProductsInCategoryScreenState extends State<ProductsInCategoryScreen> {
  var isRemember = false;
  var isInformation = true;
  var isCartAdded = false;
  var badge = 0;
  ProductModel selectedProduct;

  @override
  void initState() {
    super.initState();
    badge = SharedPrefs.getInt(SharedPrefs.KEY_BADGE_VALUE);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: offsetBase, vertical: offsetMd),
      child: Stack(
        children: [
          Column(
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
                height: offsetMd,
              ),
              Row(
                children: [
                  InkWell(
                    child: InkWell(
                      child: IconWidget(
                        icon: 'assets/icons/ic_view_product.svg',
                        iconType: ICONTYPE.Svg,
                        color: Colors.white,
                        size: 36.0,
                      ),
                      onTap: (){
                        widget.onClickProductLayout();
                      },
                    ),
                    onTap: (){
                      widget.onClickViewCategory();
                    },
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'MAKE SELECTION OR SEARCH FOR ITEM',
                        style:
                        boldText.copyWith(fontSize: fontSm, color: Colors.white),
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
              SizedBox(
                height: offsetBaseSm,
              ),
              ProductInMenus(widget.isExpand, isInformation, widget.scaffoldKey, false, (selProduct){
                  selectedProduct = selProduct;
                }, (){
                  setState(() {
                    badge += 1;
                    SharedPrefs.saveInt(SharedPrefs.KEY_BADGE_VALUE, badge);
                    isCartAdded = true;
                  });
                }
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
                height: offsetBaseSm,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isInformation = !isInformation;
                  });
                },
                child: Row(
                  children: [
                    isInformation == true ? IconWidget(
                      icon: 'assets/icons/ic_close_box.svg',
                      iconType: ICONTYPE.Svg,
                      color: Colors.white,
                      size: 24.0,
                    ) :
                    Icon(
                      Icons.check_box_outline_blank,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: offsetBase,
                    ),
                    Text(
                      'PRODUCT INFO',
                      style: semiBold.copyWith(
                          fontSize: fontBase, color: Colors.white),
                    ),
                    Spacer(),
                    InkWell(
                      child: Container(
                        width: 38, height: 38,
                        alignment: Alignment.topRight,
                        child: Badge(
                          badgeContent: Text(badge.toString(), style: TextStyle(color: Colors.white, fontSize: 16),),
                          child: Icon(Icons.shopping_cart_outlined, size: 34, color: getFocusColor(1, 1),),
                        ),
                      ),
                      onTap: (){
                        NavigatorService(context).pushToWidget(screen: CartScreen());
                      },
                    ),
                    SizedBox(width: 12,),
                  ],
                ),
              ),
            ],
          ),
          if(isCartAdded) Align(
            alignment: Alignment.center,
            child: Container(
              height: 148.0,
              padding: EdgeInsets.symmetric(horizontal: offsetMd),
              child: Center(
                child: Column(
                  children: [
                    Spacer(),
                    Text(selectedProduct.pTitle + ' ' + selectedProduct.pVol, style: boldText.copyWith(fontSize: fontXLg, color: Colors.white), maxLines: 1,),
                    Container(height: 8,),
                    Text('Added to shopping cart.', style: mediumText.copyWith(fontSize: fontLg, color: Colors.white),),
                    Container(height: 24,),
                    InkWell(child:
                      Container(
                        height: 36,
                        child: Center(child: Text('OK', style: mediumText.copyWith(fontSize: fontLg, color: textRedColor),)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(offsetMSm)),
                          color: lightYellowColor,
                        ),
                      ),
                      onTap: (){
                        setState(() {
                          isCartAdded = false;
                        });
                      },
                    ),
                    SizedBox(height: 12,),
                  ],
                )
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(offsetMSm)),
                color: unSelectedColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
