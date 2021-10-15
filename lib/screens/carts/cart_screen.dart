import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:visualvend/models/product_model.dart';
import 'package:visualvend/screens/payments/credit_card_screen.dart';
import 'package:visualvend/screens/products/product_info.dart';
import 'package:visualvend/services/navigator_service.dart';
import 'package:visualvend/utils/app_utils.dart';
import 'package:visualvend/utils/constants.dart';
import 'package:visualvend/utils/dimens.dart';
import 'package:visualvend/utils/params.dart';
import 'package:visualvend/utils/sharedpref.dart';
import 'package:visualvend/utils/themes.dart';
import 'package:visualvend/widgets/image_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key key, }) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  List<ProductModel> products = <ProductModel>[];
  String price = '50';

  @override
  void initState() {
    super.initState();
    products.clear();

    for(int i = 0; i < productsInCategory.length; i++){
      ProductModel product = new ProductModel();
      product.pTitle = productsInCategory.elementAt(i)['title'];
      product.pIcon = productsInCategory.elementAt(i)['icon'];
      product.pPrice = productsInCategory.elementAt(i)['price'];
      product.pQuantity = 5;
      product.pVol = productsInCategory.elementAt(i)['vol'];
      product.pItem = productsInCategory.elementAt(i)['item'];
      product.pFailed = false;
      products.add(product);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Container(
          child: Center(child: Text('MEDIA AD PLAYS', style: semiBold.copyWith(fontSize: 18.0),)),
          margin: EdgeInsets.only(right: 52),
        ),
        backgroundColor: Colors.white,
        leading: InkWell(
          child: IconWidget(
            iconType: ICONTYPE.IconData,
            icon: MdiIcons.arrowLeftBold,
            size: 42.0,
            color: Colors.blue,
          ),
          onTap: (){
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: offsetBase, vertical: offsetMd),
        child: Column(
          children: [
            Container(
              child: Container(
                child: Center(child: Text('All Products in your cart', style: semiBold.copyWith(fontSize: 20.0),)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 6, left: 6, right: 6, top: 20),
              height: 1, color: Colors.blue.withOpacity(0.7),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index){
                  return InkWell(
                    child: ProductUI(products.elementAt(index), index, (){

                    }),
                    onTap: (){
                      showProductInfo(products.elementAt(index));
                    },
                  );
                },
                itemCount: products.length,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 12, left: 6, right: 6),
              height: 1, color: Colors.blue.withOpacity(0.7),
            ),
            Container(
              margin: EdgeInsets.only(left: 12, right: 12, top: 16, bottom: 12),
              child: Row(
                children: [
                  Text('Total Price : ', style:  semiBold.copyWith(fontSize: fontLg, color: Colors.black),),
                  Expanded(child: Container()),
                  Text('\$ 50', style:  semiBold.copyWith(fontSize: fontLg, color: Colors.black),),
                ],
              ),
            ),
            InkWell(
              child: Container(
                width: double.infinity,
                child: Container(
                  width: double.infinity, height: 40,
                  margin: EdgeInsets.only(left: 38, right: 38, top: 20),
                  child: Center(child: Text('Confirm to Vend', style: semiBold.copyWith(fontSize: fontMMd, color: Colors.white),)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(offsetMSm)),
                    color: Colors.green,
                  ),
                ),
              ),
              onTap: (){
                onClickConfirm();
              },
            ),
          ],
        ),
        color: Colors.white,
      ),
    );
  }

  void showProductInfo(ProductModel elementAt) {
    NavigatorService(context).pushToWidget(screen: ProductInfoScreen(product: elementAt, ));
  }

  void onClickConfirm() {
    bool creditCardAdded = SharedPrefs.getBool(SharedPrefs.KEY_CREDIT_CARD_ADDED);
    if(creditCardAdded){
      paymentProcess();
    }else{
      showBanner(context, scaffoldKey, bannerData[1]['title'], bannerData[1]['type'], (){
        paymentProcess();
      });
    }
  }

  paymentProcess(){
    NavigatorService(context).pushToWidget(screen: CreditCardScreen(price: price, onBackCallback: (_callback){
      if(_callback){
        showBanner(context, scaffoldKey, bannerData[0]['title'], bannerData[0]['type'], (){
          showVendSuccessDialog(context, '', price, (){
            Navigator.of(context, rootNavigator: true).pop();
          });
        });
      }else{
        showBanner(context, scaffoldKey, bannerData[5]['title'], bannerData[5]['type'], (){});
      }
    },));
  }
}

