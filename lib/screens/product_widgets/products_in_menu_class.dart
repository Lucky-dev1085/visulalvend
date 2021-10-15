import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visualvend/models/product_model.dart';
import 'package:visualvend/screens/payments/credit_card_screen.dart';
import 'package:visualvend/screens/products/product_info.dart';
import 'package:visualvend/services/navigator_service.dart';
import 'package:visualvend/utils/app_utils.dart';
import 'package:visualvend/utils/colors.dart';
import 'package:visualvend/utils/dimens.dart';
import 'package:visualvend/utils/params.dart';
import 'package:visualvend/utils/sharedpref.dart';
import 'package:visualvend/utils/themes.dart';

class ProductInMenus extends StatefulWidget {
  final bool isExpand;
  final bool isInformation;
  final bool willPopUpInStart;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function(ProductModel) onClickProductItem;
  final Function() cartAdded;

  const ProductInMenus(this.isExpand, this.isInformation, this.scaffoldKey, this.willPopUpInStart, this.onClickProductItem, this.cartAdded);

  @override
  _ProductInMenusState createState() => _ProductInMenusState();
}

class _ProductInMenusState extends State<ProductInMenus> {
  List<ProductModel> products = <ProductModel>[];
  ProductModel selectedProduct;
  var badge = 0;

  @override
  void initState() {
    super.initState();
    badge = SharedPrefs.getInt(SharedPrefs.KEY_BADGE_VALUE);
    initProducts();
    WidgetsBinding.instance.addPostFrameCallback((_) => showPopUpIfAavailable());
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        shrinkWrap: true,
        padding: EdgeInsets.all(offsetSm),
        crossAxisCount: widget.isExpand ? 3 : 2,
        childAspectRatio: widget.isExpand ? 1 : 2,
        children: [
          if(products.length > 0)
            for(ProductModel product in products) InkWell(
              onTap: (){
                selectedProduct = product;
                widget.onClickProductItem(product);
                onClickProductCell(context, product);
              },
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(offsetMSm),
                    padding: EdgeInsets.all(offsetXSm),
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.circular(offsetSm)),
                      color: normalGreyColor,
                    ),
                    child: widget.isExpand ? Column(
                      children: [
                        Expanded(child: Image.asset(product.pIcon)),
                        SizedBox(
                          height: offsetSm,
                        ),
                        Text(
                          product.pTitle.toString().toUpperCase(),
                          style: boldText.copyWith(fontSize: fontSm, color: Colors.white),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                        )
                      ],
                    ) :
                    Center(
                      child: Text(product.pTitle.toString().toUpperCase(),
                        style: boldText.copyWith(fontSize: fontXLg, color: Colors.white),
                      ),
                    ),
                  ),
                  if (product.pFailed) Center(
                    child: Icon(
                      Icons.not_interested,
                      size: 75.0,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
        ],
      )
    );
  }

  void onTapVendNow(BuildContext _context) {
    Navigator.of(_context, rootNavigator: true).pop();
    bool creditCardAdded = SharedPrefs.getBool(SharedPrefs.KEY_CREDIT_CARD_ADDED);
    if(creditCardAdded){
      paymentProcess(_context);
    }else{
      showBanner(_context, widget.scaffoldKey, bannerData[1]['title'], bannerData[1]['type'], (){
        paymentProcess(_context);
      });
    }
  }

  void onTapAddCart(BuildContext _context) {
    Navigator.of(_context, rootNavigator: true).pop();
    showBanner(_context, widget.scaffoldKey, bannerData[4]['title'], bannerData[4]['type'], (){
      widget.cartAdded();
    });
  }

  void onTapProduct(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
    NavigatorService(context).pushToWidget(screen: ProductInfoScreen(product: selectedProduct, ));
  }

  paymentProcess(BuildContext context){
    NavigatorService(context).pushToWidget(screen: CreditCardScreen(price: selectedProduct.pPrice, onBackCallback: (_callback){
      if(_callback){
        showBanner(context, widget.scaffoldKey, bannerData[0]['title'], bannerData[0]['type'], (){
          showVendSuccessDialog(context, selectedProduct.pIcon, selectedProduct.pPrice, (){

          });
        });
      }else{
        showBanner(context, widget.scaffoldKey, bannerData[5]['title'], bannerData[5]['type'], (){});
      }
    },
    ));
  }

  void onClickProductCell(BuildContext _context, ProductModel product) {
    onClickProduct(_context, product, widget.isInformation, (){
      onTapProduct(_context);
    }, (){
      showVendFailedDialog(_context);
    }, (){
      showVendDialog(_context, (){
        onTapVendNow(_context);
      }, (){
        onTapAddCart(_context);
      });
    });
  }

  void initProducts() {
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

  showPopUpIfAavailable() {
    if(widget.willPopUpInStart){
      onClickProductCell(context, products.elementAt(0));
    }
  }
}