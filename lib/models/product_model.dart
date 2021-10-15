
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visualvend/utils/dimens.dart';
import 'package:visualvend/utils/themes.dart';

class ProductModel {
  String pId;
  String pTitle;
  String pVol;
  String pIcon;
  String pItem;
  String pPrice;
  int pQuantity;
  bool pFailed;

  ProductModel({this.pId = '', this.pTitle = '', this.pPrice = '', this.pVol = '', this.pQuantity = 0, this.pIcon = '', this.pItem = '16', this.pFailed = false});
}

class ProductUI extends StatelessWidget {
  final ProductModel product;
  final int productIndex;
  final Function onClicked;

  const ProductUI(this.product, this.productIndex, this.onClicked,);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if(productIndex != 0)Container(
          height: 1,
          margin: EdgeInsets.symmetric(horizontal: 6),
          color: Colors.blue.withOpacity(0.7),
        ),
        Container(
          padding: EdgeInsets.all(offsetBaseSm),
          child: Row(
            children: [
              Container(
                child: Center(child: Image.asset(product.pIcon, height: 48,)),
                alignment: Alignment.topLeft,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Column(
                    children: [
                      Text(product.pTitle, style:  semiBold.copyWith(fontSize: fontMd, color: Colors.black), maxLines: 1,),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 8, top: 4),
                                  child: Text('Massive: ' + product.pVol, style:  semiBold.copyWith(fontSize: fontSm, color: Colors.black), maxLines: 1,)
                                ),
                                Container(
                                    margin: EdgeInsets.only(left: 8, top: 2),
                                    child: Text('Price: \$ ' + product.pPrice, style:  semiBold.copyWith(fontSize: fontSm, color: Colors.black), maxLines: 1,)
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              children: [
                                Text('Quantity: ', style:  semiBold.copyWith(fontSize: fontSm, color: Colors.black),),
                                Text(' ' + product.pQuantity.toString() , style:  semiBold.copyWith(fontSize: fontSm, color: Colors.black),),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
              ),

              Container(
                width: 48, height: 64,
                child: Column(
                  children: [
                    InkWell(
                      child: Icon(Icons.add_box_rounded, size: 28,),
                      onTap: (){
                        onClickAddQuantity();
                      },
                    ),
                    SizedBox(height: 6,),
                    InkWell(
                      child: Icon(Icons.indeterminate_check_box, size: 28,),
                      onTap: (){
                        onClickRemoveProduct();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void onClickAddQuantity() {

  }

  void onClickRemoveProduct() {

  }
}