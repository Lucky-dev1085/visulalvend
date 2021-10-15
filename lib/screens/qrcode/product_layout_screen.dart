import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visualvend/models/product_model.dart';
import 'package:visualvend/screens/carts/cart_screen.dart';
import 'package:visualvend/screens/payments/credit_card_screen.dart';
import 'package:visualvend/screens/products/product_info.dart';
import 'package:visualvend/services/navigator_service.dart';
import 'package:visualvend/utils/app_utils.dart';
import 'package:visualvend/utils/colors.dart';
import 'package:visualvend/utils/constants.dart';
import 'package:visualvend/utils/dimens.dart';
import 'package:visualvend/utils/params.dart';
import 'package:visualvend/utils/sharedpref.dart';
import 'package:visualvend/utils/themes.dart';
import 'package:visualvend/widgets/image_widget.dart';

import '../../models/product_model.dart';

class ProductLayoutScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function() onClickManualMachine;
  final Function() onClickProductMenu;

  const ProductLayoutScreen({
    Key key,
    this.scaffoldKey,
    this.onClickManualMachine,
    this.onClickProductMenu,
  }) : super(key: key);

  @override
  _ProductLayoutScreenState createState() =>
      _ProductLayoutScreenState();
}

class _ProductLayoutScreenState extends State<ProductLayoutScreen> {
  var isRemember = false;
  var isInformation = true;
  var bannerIndex = 0;
  var isCartAdded = false;
  var badge = 0;

  ProductModel selectedItem;
  List<List<ProductModel>> productLists = [];

  @override
  void initState() {
    super.initState();
    badge = SharedPrefs.getInt(SharedPrefs.KEY_BADGE_VALUE);
    initProductModelList();
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
                height: offsetLg,
              ),
              Row(
                children: [
                  InkWell(
                    child: IconWidget(
                      icon: 'assets/icons/ic_vend_select.svg',
                      iconType: ICONTYPE.Svg,
                      color: Colors.white,
                      size: 32.0,
                    ),
                    onTap: (){
                      widget.onClickProductMenu();
                    },
                  ),
                  Expanded(
                      child: Center(
                        child: Text(
                          'MAKE SELECTION OR SEARCH FOR ITEM',
                          style:
                          boldText.copyWith(fontSize: fontSm, color: Colors.white),
                        ),
                      )),
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
                height: offsetBase,
              ),
              Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (List<ProductModel> list in productLists) SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for (ProductModel item in list) InkWell(
                                onTap: (){
                                  selectedItem = item;
                                  onClickProductItem();
                                },
                                child: Container(
                                  margin: EdgeInsets.all(offsetXSm),
                                  padding: EdgeInsets.all(offsetSm),
                                  width: MediaQuery.of(context).size.width / 5,
                                  height: MediaQuery.of(context).size.width / 5 * 1.4,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(offsetXSm)),
                                      color: lightGreyColor
                                  ),
                                  child: Column(
                                    children: [
                                      Expanded(child: Image.asset(item.pIcon,)),
                                      SizedBox(height: offsetSm,),
                                      Text(item.pTitle,
                                        style: semiBold.copyWith(fontSize: fontSm),
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
              SizedBox(
                height: offsetBaseSm,
              ),
              Row(
                children: [
                  InkWell(
                    child: Row(
                      children: [
                        isInformation == true ? IconWidget(
                          icon: 'assets/icons/ic_close_box.svg',
                          iconType: ICONTYPE.Svg,
                          color: Colors.white,
                          size: 24.0,
                        ) : Icon(
                          Icons.check_box_outline_blank,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: offsetMSm,
                        ),
                        Text(
                          'Product Info'.toUpperCase(),
                          style: semiBold.copyWith(
                              fontSize: fontBase, color: Colors.white),
                        ),
                      ],
                    ),
                    onTap: (){
                      setState(() {
                        isInformation = !isInformation;
                      });
                    },
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
              )
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
                      Text(selectedItem.pTitle + ' ' + selectedItem.pVol, style: boldText.copyWith(fontSize: fontXLg, color: Colors.white), maxLines: 1,),
                      Container(height: 8,),
                      Text('Added to shopping cart.', style: mediumText.copyWith(fontSize: fontLg, color: Colors.white),),
                      Container(height: 24,),
                      InkWell(child: Container(
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

  void initProductModelList() {
    productLists.clear();
    for(var itemList in productListsJson){
      List<ProductModel> products = [];
      for(var item in itemList){
        ProductModel product = new ProductModel();
          product.pTitle = item['title'];
          product.pIcon = item['icon'];
          product.pPrice = item['price'];
          product.pQuantity = int.parse(item['qty']);
          product.pVol = item['vol'];
          product.pItem = item['item'];
          product.pFailed = false;
          products.add(product);
      }
      productLists.add(products);
    }
    setState(() {});
  }

  onTapProduct() {
    Navigator.of(context, rootNavigator: true).pop();
    NavigatorService(context).pushToWidget(screen: ProductInfoScreen(product: selectedItem, ));
  }

  void onTapVendNow() {
    Navigator.of(context, rootNavigator: true).pop();
    bool creditCardAdded = SharedPrefs.getBool(SharedPrefs.KEY_CREDIT_CARD_ADDED);
    if(creditCardAdded){
      paymentProcess();
    }else{
      showBanner(context, widget.scaffoldKey, bannerData[1]['title'], bannerData[1]['type'], (){
        paymentProcess();
      });
    }
  }

  void onTapAddCart() {
    Navigator.of(context, rootNavigator: true).pop();
    showBanner(context, widget.scaffoldKey, bannerData[4]['title'], bannerData[4]['type'], (){
      setState(() {
        badge += 1;
        SharedPrefs.saveInt(SharedPrefs.KEY_BADGE_VALUE, badge);
        isCartAdded = true;
      });
    });
  }

  paymentProcess(){
    NavigatorService(context).pushToWidget(screen: CreditCardScreen(price: selectedItem.pPrice, onBackCallback: (_callback){
      if(_callback){
        showBanner(context, widget.scaffoldKey, bannerData[0]['title'], bannerData[0]['type'], (){
          showVendSuccessDialog(context, selectedItem.pIcon, selectedItem.pPrice, (){

          });
        });
      }else{
        showBanner(context, widget.scaffoldKey, bannerData[5]['title'], bannerData[5]['type'], (){});
      }
    },
    ));
  }

  void onClickProductItem() {
    onClickProduct(context, selectedItem, isInformation, (){
        onTapProduct();
      },
      (){
        showVendFailedDialog(context);
      },
      (){
        showVendDialog(context, (){
          onTapVendNow();
      },
      (){
          onTapAddCart();
      });
    });
  }
}
