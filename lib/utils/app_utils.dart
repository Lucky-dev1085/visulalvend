import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:visualvend/models/product_model.dart';
import 'package:visualvend/services/dialog_service.dart';
import 'package:visualvend/utils/themes.dart';

import 'colors.dart';
import 'constants.dart';
import 'dimens.dart';

double screenHeight = 0.0;
double screenWidth = 0.0;

double topBarHeight = 60;
double bottomBarHeight = 52;
double statusBarHeight = 32;

void showToast(String msg){
  Fluttertoast.showToast(
    msg: msg,
    textColor: Colors.white,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.green,
  );
}

void showBanner(BuildContext context, GlobalKey<ScaffoldState> scaffoldKey, String text, SnackBarType type, Function func) {
  DialogService(context).showSnackbar(
    text, scaffoldKey,
    type: type,
    dismiss: func,
    milliseconds: 2000,
  );
}

void showVendSuccessDialog(BuildContext context, String assetPath, String price, Function func) {
  DialogService(context).showCustomDialog(
    contentWidget: Center(
      child: Container(
        color: lightGreyColor,
        width: MediaQuery.of(context).size.width / 4 * 3,
        padding: EdgeInsets.all(offsetBase),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            assetPath != '' ? Image.asset(assetPath, height: 120.0,) :
            Image.asset('assets/icons/ic_vend_machine.png', width: 72,),
            SizedBox(
              height: offsetBase,
            ),
            Text(
              'Vended - OK',
              style: boldText.copyWith(fontSize: fontXLg, color: Colors.black),
            ),
            SizedBox(
              height: offsetSm,
            ),
            Text(
              '\$ ' + price + ' incl. Surcharge',
              style: semiBold.copyWith(fontSize: fontMd, color: Colors.black),
            ),
            SizedBox(
              height: offsetBase,
            ),
            Text(
              'Enjoy and ...\nHave a Nice day !!!',
              style:
              semiBold.copyWith(fontSize: fontXLg, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: offsetBase,
            ),
            Text(
              'Item is on left of tray',
              style: semiBold.copyWith(fontSize: fontLg, color: Colors.black),
            ),
            SizedBox(
              height: offsetBase,
            ),
            InkWell(
              onTap: (){
                Navigator.of(context, rootNavigator: true).pop();
                func();
              },
              child: Container(
                width: double.infinity,
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_drop_down,
                      size: 32.0,
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 32.0,
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 32.0,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

void onClickProduct(BuildContext context, ProductModel item, bool isShowInfo, Function func, Function vendFailed, Function vendDialog) {
  DialogService(context).showCustomDialog(
    contentWidget: Center(
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width / 2.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: offsetSm,),
            Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: offsetBase),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/icons/ic_lock.png',
                            width: 32.0,
                            height: 32.0,
                          ),
                          InkWell(
                            onTap: () => Navigator.of(context, rootNavigator: true).pop(),
                            child: Icon(
                              Icons.close,
                              size: 32.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Image.asset(
                      item.pIcon,
                      height: 75.0,
                    ),
                    SizedBox(
                      height: offsetSm,
                    ),
                    Text(
                      '${item.pTitle} ${item.pVol}',
                      style: boldText.copyWith(fontSize: fontMd, color: Colors.black),
                    ),
                    SizedBox(
                      height: offsetSm,
                    ),
                    Text(
                      'Qty ${item.pQuantity}',
                      style: semiBold.copyWith(fontSize: fontBase, color: Colors.black),
                    ),
                    SizedBox(
                      height: offsetSm,
                    ),
                    Text(
                      '${item.pPrice}',
                      style: boldText.copyWith(fontSize: fontLg, color: Colors.black),
                    ),
                    SizedBox(
                      height: offsetSm,
                    ),
                    Text(
                      'Item ${item.pItem}',
                      style: boldText.copyWith(fontSize: fontBase, color: Colors.black),
                    ),
                  ],
                ),
                if (item.pFailed)
                  Container(
                    padding: EdgeInsets.only(top: 50.0),
                    child: Center(
                      child: Icon(
                        Icons.not_interested,
                        size: 120.0,
                        color: Colors.red,
                      )
                    ),
                  ),
              ],
            ),
            SizedBox(
              height: offsetSm,
            ),
            Row(
              children: [
                if(isShowInfo) Expanded(
                  child: Container(
                    height: 44.0,
                    decoration: BoxDecoration(
                      color: blueColor,
                      border: Border(
                        top: BorderSide(color: Colors.black, width: 1.0),
                        right: BorderSide(color: Colors.black, width: 1.0),
                      ),
                    ),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          func();
                        },
                        child: Text(
                          'INFO',
                          style: semiBold.copyWith(fontSize: fontLg, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).pop();
                      if (item.pFailed) {
                        vendFailed();
                      } else {
                        vendDialog();
                      }
                    },
                    child: Container(
                      height: 44.0,
                      decoration: BoxDecoration(
                        color: blueColor,
                        border: Border(top: BorderSide(color: Colors.black, width: 1.0), ),
                      ),
                      child: Center(
                        child: Text('BUY', style: semiBold.copyWith(fontSize: fontLg, color: Colors.white),),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    )
  );
}

void showVendFailedDialog(BuildContext context) {
  DialogService(context).showCustomDialog(
    contentWidget: Center(
      child: Container(
        width: MediaQuery.of(context).size.width / 5 * 4,
        padding: EdgeInsets.all(offsetBase),
        decoration: BoxDecoration(
          color: Colors.orange,
          border: Border.all(color: Colors.black, width: 2.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'You have NOT been charged',
              style: boldText.copyWith(fontSize: fontLg),
            ),
            SizedBox(
              height: offsetSm,
            ),
            Text(
              'any pre-authorisation amount has been refunded to your bank. Please make another selection',
              style: semiBold.copyWith(fontSize: fontMd),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: offsetBase,
            ),
            InkWell(
              onTap: () => Navigator.of(context, rootNavigator: true).pop(),
              child: Container(
                color: Colors.deepOrange,
                padding: EdgeInsets.symmetric(horizontal: offsetBase, vertical: offsetSm),
                child: Text(
                  'OK',
                  style: boldText.copyWith(fontSize: fontXLg, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void showVendDialog(BuildContext context, Function tapVend, Function tapCart) {
  DialogService(context).showCustomDialog(
    contentWidget: Center(
      child: Container(
        width: MediaQuery.of(context).size.width / 5.0 * 4,
        color: darkBlueColor,
        padding:
        EdgeInsets.symmetric(horizontal: offsetBase, vertical: offsetBase),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select to Vend or Add to Cart',
              style: boldText.copyWith(fontSize: fontLg, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: offsetSm,
            ),
            Row(
              children: [
                Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: InkWell(
                        onTap: (){
                          tapVend();
                        },
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(offsetSm),
                          child: Column(
                            children: [
                              Expanded(
                                  child: SvgPicture.asset(
                                    'assets/icons/ic_vend_select.svg',
                                    color: Colors.black,
                                  )),
                              SizedBox(
                                height: offsetSm,
                              ),
                              Text(
                                'Vend Now',
                                style: boldText.copyWith(fontSize: fontMd),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                SizedBox(
                  width: offsetMd,
                ),
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: InkWell(
                      onTap: () {
                        tapCart();
                      },
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(offsetSm),
                        child: Column(
                          children: [
                            Expanded(child: SvgPicture.asset('assets/icons/ic_cart.svg')),
                            SizedBox(height: offsetSm, ),
                            Text('Add to Cart', style: boldText.copyWith(fontSize: fontMd),),
                          ],
                        ),
                      ),
                    ),
                  )
                ),
              ],
            )
          ],
        ),
      ),
    )
  );
}