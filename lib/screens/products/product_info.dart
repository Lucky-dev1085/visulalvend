import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:visualvend/models/product_model.dart';
import 'package:visualvend/utils/constants.dart';
import 'package:visualvend/utils/dimens.dart';
import 'package:visualvend/utils/themes.dart';
import 'package:visualvend/widgets/image_widget.dart';

class ProductInfoScreen extends StatefulWidget {
  final ProductModel product;
  ProductInfoScreen({Key key, this.product}) : super(key: key);

  @override
  _ProductInfoScreenState createState() => _ProductInfoScreenState();
}

class _ProductInfoScreenState extends State<ProductInfoScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MEDIA AD PLAYS', style: semiBold.copyWith(fontSize: 18.0),),
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: offsetBase, vertical: offsetMd),
        child: Column(
          children: [
            Container(
              width: double.infinity, height: 240,
              child: Image.asset(widget.product.pIcon, height: 240,),
            ),
            SizedBox(height: 24,),
            Text('Title :  ' + widget.product.pTitle, style: semiBold.copyWith(fontSize: fontLg, color: Colors.black),),
            SizedBox(height: 12,),
            Text('Vol   :  ' + widget.product.pVol, style: semiBold.copyWith(fontSize: fontLg, color: Colors.black),),
            SizedBox(height: 12,),
            Text('Price :  \$ ' + widget.product.pPrice, style: semiBold.copyWith(fontSize: fontLg, color: Colors.black),),
            SizedBox(height: 12,),
            Text('Item  :   ' + widget.product.pItem, style: semiBold.copyWith(fontSize: fontLg, color: Colors.black),),
            Expanded(child: Container()),
            InkWell(
              onTap: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: Center(
                child: IconWidget(
                  iconType: ICONTYPE.IconData,
                  icon: MdiIcons.arrowLeftBold,
                  size: 42.0,
                  color: Colors.blue,
                )
              ),
            )
          ],
        ),
      )
    );
  }
}



