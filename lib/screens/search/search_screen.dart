
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:visualvend/models/product_model.dart';
import 'package:visualvend/screens/carts/cart_screen.dart';
import 'package:visualvend/screens/product_widgets/products_in_menu_class.dart';
import 'package:visualvend/services/navigator_service.dart';
import 'package:visualvend/utils/app_utils.dart';
import 'package:visualvend/utils/colors.dart';
import 'package:visualvend/utils/constants.dart';
import 'package:visualvend/utils/dimens.dart';
import 'package:visualvend/utils/sharedpref.dart';
import 'package:visualvend/utils/themes.dart';
import 'package:visualvend/widgets/appbar.dart';
import 'package:visualvend/widgets/image_widget.dart';

class SearchScreen extends StatefulWidget {
  final String title;
  final String searchCategory;
  final String searchKey;
  final bool willPopUpProduct;
  final Function onclickBack;

  const SearchScreen({Key key, this.searchKey, this.searchCategory, @required this.title, this.willPopUpProduct, this.onclickBack, }) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  var isCartAdded = false;
  var badge = 0;
  var isInformation = true;
  ProductModel selectedProduct;

  @override
  void initState() {
    super.initState();
    badge = SharedPrefs.getInt(SharedPrefs.KEY_BADGE_VALUE);
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height - topBarHeight - bottomBarHeight - statusBarHeight;
    return Scaffold(
      key: scaffoldKey,
      appBar: NoTitleAppBar(),
      body: mainBody(),
      backgroundColor: darkGreyColor,
    );
  }

  mainBody() {
    return Container(
      padding: EdgeInsets.only(left: offsetBase, right: offsetBase, top: offsetBase, bottom: offsetBaseSm),
      child: Stack(
        children: [
          Column(
            children: [
              Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Center(child: Text(widget.title, style: semiBold.copyWith(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),)),
                  Row(
                    children: [
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Icon(Icons.arrow_back_ios, size: 26, color: Colors.white,),
                        ),
                        onTap: (){
                          widget.onclickBack();
                        },
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: offsetMd,
              ),
              if(widget.searchCategory != '')Row(children: [
                  Text('Search Category :  ',
                    style: boldText.copyWith(fontSize: fontMd, color: Colors.white),
                  ),
                  Text(widget.searchCategory,
                    style: boldText.copyWith(fontSize: fontBase, color: Colors.white),
                  ),
                ],
              ),
              if(widget.searchKey != '')Row(
                children: [
                  Text(
                    'Search Key :  ',
                    style: boldText.copyWith(fontSize: fontMd, color: Colors.white),
                  ),
                  Text(
                    widget.searchKey,
                    style: boldText.copyWith(fontSize: fontBase, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(
                height: offsetMd,
              ),
              SizedBox(
                height: offsetBaseSm,
              ),
              ProductInMenus(true, true, scaffoldKey, widget.willPopUpProduct, (selProduct){
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
                    InkWell(
                      child: Container(
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
                ),
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

