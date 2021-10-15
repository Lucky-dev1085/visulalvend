import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:visualvend/models/product_model.dart';
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
import 'package:visualvend/widgets/dropbox_widget.dart';
import 'package:visualvend/widgets/image_widget.dart';
import 'package:visualvend/widgets/textfield_widget.dart';

class ManualMachineScreen extends StatefulWidget {
  final Function() onClickQRInput;
  final Function() onClickProductCategory;
  final Function() onClickProductMenu;

  const ManualMachineScreen({Key key, @required this.onClickQRInput, this.onClickProductCategory, this.onClickProductMenu, })
      : super(key: key);

  @override
  _ManualMachineScreenState createState() => _ManualMachineScreenState();
}

class _ManualMachineScreenState extends State<ManualMachineScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  var controller = TextEditingController();
  var isInformation = false;
  var selectedZom = '50%';
  var isCartAdded = false;

  ProductModel product = new ProductModel();

  _addText(String str) {
    if (str == 'OK') {
      if(controller.text.isNotEmpty){
        onClickProduct(context, product, isInformation, (){
          onTapProduct();
        },
        (){
          showVendFailedDialog(context);
        },
        (){
          showVendDialog(context, (){
            onTapVendNow();
          }, (){
            onTapAddCart();
          });
        });
      }else{
        showToast('Please enter machine ID.');
      }

    } else {
      String inputValue = controller.text;
      String newStr = inputValue + str;
      setState(() {
        controller.text = newStr;
      });
    }
  }

  _backspace() {
    String inputValue = controller.text;
    if (inputValue.isNotEmpty) {
      String newStr = inputValue.substring(0, inputValue.length - 1);
      setState(() {
        controller.text = newStr;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    product.pTitle = 'Coke';
    product.pIcon = 'assets/icons/ic_beer.png';
    product.pVol = '370ml';
    product.pQuantity =5;
    product.pPrice = '2.2';
    product.pItem = '16';
    product.pFailed = false;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: backgroundColor,
        body: Container(
          padding: EdgeInsets.only(left: offsetBase, right: offsetBase, top: 18, bottom: 18),
          child: Stack(
            children: [
              Column(
                children: [
                  Text(
                    'CONNECT TO SITE 12',
                    style:
                    boldText.copyWith(fontSize: fontXLg, color: selectedColor),
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
                  Container(
                    width: double.infinity,
                    height: 48.0,
                    padding: EdgeInsets.symmetric(horizontal: offsetBase, vertical: offsetMSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(offsetSm),
                      ),
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () => widget.onClickQRInput(),
                          child: Icon(MdiIcons.creditCardScan)
                        ),
                        SizedBox(
                          width: offsetBase,
                        ),
                        Expanded(
                          child: NoOutLineTextField(
                            controller: controller,
                            keyboardType: null,
                            hint: 'ENTER AISLE NO# TO VEND',
                            padding: EdgeInsets.symmetric(vertical: 12.0),
                            textAlign: TextAlign.center,
                          )
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Expanded(
                      child: Column(
                        children: [
                          for (var keyRow in keyBoards)
                            Expanded(
                              child: Row(
                                children: [
                                  for (var key in keyRow)
                                    Expanded(
                                      child: Center(
                                        child: key['type'] == 'Text' ? InkWell(
                                          onTap: () => _addText(key['title']),
                                          child: Container(
                                            width: 56.0,
                                            height: 56.0,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(Radius.circular(56.0 / 2)),
                                            ),
                                            child: Center(
                                              child: Text(
                                                key['title'],
                                                style: boldText.copyWith(fontSize: 26.0),
                                              ),
                                            ),
                                          ),
                                        ) :
                                        InkWell(
                                          onTap: () => _backspace(),
                                          child: Container(
                                            width: 56.0,
                                            height: 56.0,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(Radius.circular(56.0 / 2)),
                                            ),
                                            child: Center(
                                              child: Icon(
                                                key['title'],
                                                size: 26,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            )
                        ],
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: IconWidget(
                          icon: 'assets/icons/ic_view_product.svg',
                          iconType: ICONTYPE.Svg,
                          color: Colors.white,
                          size: 44.0,
                        ),
                        onTap: (){
                          widget.onClickProductCategory();
                        },
                      ),
                      InkWell(
                        child: IconWidget(
                          icon: 'assets/icons/ic_vend_select.svg',
                          iconType: ICONTYPE.Svg,
                          color: Colors.white,
                          size: 36.0,
                        ),
                        onTap: (){
                          widget.onClickProductMenu();
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: offsetBase,
                  ),
                  Row(
                    children: [
                      InkWell(
                        child: Row(
                          children: [
                            isInformation ? IconWidget(
                              icon: 'assets/icons/ic_close_box.svg',
                              iconType: ICONTYPE.Svg,
                              color: Colors.white,
                            ) :
                            Icon(
                              Icons.check_box_outline_blank,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: offsetMSm,
                            ),
                            Text(
                              'Product Info'.toUpperCase(),
                              style: semiBold.copyWith(fontSize: fontBase, color: Colors.white),
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
                      Text(
                        'ZOOM',
                        style: semiBold.copyWith(fontSize: fontBase, color: Colors.white),
                      ),
                      SizedBox(
                        width: offsetBase,
                      ),
                      Container(
                        child: DropDownWidget(
                          iconColor: Colors.black,
                          textColor: Colors.black,
                          spinColor: Colors.black,
                          spinnerItems: ['25%', '50%', '75%', '100%'],
                          selectedText: selectedZom,
                          backColor: Colors.white,
                          onChanged: (value) {
                            setState(() {
                              selectedZom = value;
                            });
                          }
                        ),
                      ),
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
                        Text(product.pTitle + ' ' + product.pVol, style: boldText.copyWith(fontSize: fontXLg, color: Colors.white), maxLines: 1,),
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
        ),
      ),
    );
  }

  onTapProduct() {
    Navigator.of(context, rootNavigator: true).pop();
    NavigatorService(context).pushToWidget(screen: ProductInfoScreen(product: product, ));
  }

  void onTapVendNow() {
    Navigator.of(context, rootNavigator: true).pop();
    bool creditCardAdded = SharedPrefs.getBool(SharedPrefs.KEY_CREDIT_CARD_ADDED);
    if(creditCardAdded){
      paymentProcess();
    }else{
      showBanner(context, scaffoldKey, bannerData[1]['title'], bannerData[1]['type'], (){
        paymentProcess();
      });
    }
  }

  void onTapAddCart() {
    Navigator.of(context, rootNavigator: true).pop();
    showBanner(context, scaffoldKey, bannerData[4]['title'], bannerData[4]['type'], (){
      setState(() {
        isCartAdded = true;
      });
    });
  }

  paymentProcess(){
    NavigatorService(context).pushToWidget(screen: CreditCardScreen(price: product.pPrice, onBackCallback: (_callback){
      if(_callback){
        showBanner(context, scaffoldKey, bannerData[0]['title'], bannerData[0]['type'], (){
          showVendSuccessDialog(context, '', product.pPrice, (){

          });
        });
      }else{
        showBanner(context, scaffoldKey, bannerData[5]['title'], bannerData[5]['type'], (){});
      }
    },
    ));
  }
}
