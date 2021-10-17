import 'package:flutter/material.dart';
import 'package:visualvend/models/product_model.dart';
import 'package:visualvend/screens/contents_manage/product_contents.dart';
import 'package:visualvend/services/navigator_service.dart';
import 'package:visualvend/utils/colors.dart';
import 'package:visualvend/utils/dimens.dart';
import 'package:visualvend/utils/params.dart';
import 'package:visualvend/utils/themes.dart';

class ProductList extends StatefulWidget {
  final String machineId;
  final String categoryId;

  const ProductList({Key key, this.machineId, this.categoryId})
      : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  ProductModel selectedItem;
  List<ProductModel> products = <ProductModel>[];

  @override
  void initState() {
    super.initState();

    initProductModelList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.white,
            child: Column(children: [
              Container(
                width: double.infinity,
                height: 52,
                // color: Colors.black,
                margin: EdgeInsets.only(top: 15),
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Center(
                        child: Text(
                      '${widget.machineId + " / " + widget.categoryId + " Products"}',
                      style: semiBold.copyWith(
                          fontSize: 26,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )),
                    Row(
                      children: [
                        InkWell(
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 12, top: 8, right: 8, bottom: 8),
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 26,
                              color: Colors.black,
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  NavigatorService(context).pushToWidget(
                      screen: ProductContents(
                    machineId: widget.machineId,
                    categoryId: widget.categoryId,
                    productId: "",
                  ));
                },
                icon: Icon(Icons.add, size: 18),
                label: Text("Add"),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: GridView.count(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(offsetSm),
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  children: [
                    if (products.length > 0)
                      for (ProductModel product in products)
                        InkWell(
                          onTap: () {
                            NavigatorService(context).pushToWidget(
                                screen: ProductContents(
                                    machineId: widget.machineId,
                                    categoryId: widget.categoryId,
                                    productId: product.pTitle));
                          },
                          child: Stack(
                            children: [
                              Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.all(offsetMSm),
                                  padding: EdgeInsets.all(offsetXSm),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(offsetSm)),
                                    color: normalGreyColor,
                                  ),
                                  child: Column(
                                    children: [
                                      Expanded(
                                          child: Image.asset(product.pIcon)),
                                      SizedBox(
                                        height: offsetSm,
                                      ),
                                      Text(
                                        product.pTitle.toString().toUpperCase(),
                                        style: boldText.copyWith(
                                            fontSize: fontSm,
                                            color: Colors.white),
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                      )
                                    ],
                                  )),
                              if (product.pFailed)
                                Center(
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
                ),
              ),
            ])));
  }

  void initProductModelList() {
    products.clear();

    for (int i = 0; i < productsInCategory.length; i++) {
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
}
