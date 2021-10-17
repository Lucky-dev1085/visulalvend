import 'package:flutter/material.dart';
import 'package:visualvend/screens/contents_manage/category_contents.dart';
import 'package:visualvend/screens/contents_manage/product_contents.dart';
import 'package:visualvend/screens/contents_manage/product_list.dart';
import 'package:visualvend/services/navigator_service.dart';
import 'package:visualvend/utils/dimens.dart';
import 'package:visualvend/utils/params.dart';
import 'package:visualvend/utils/themes.dart';

class ProductCategory extends StatefulWidget {
  final String machineId;

  const ProductCategory({Key key, this.machineId}) : super(key: key);

  @override
  _ProductCategoryState createState() => _ProductCategoryState();
}

class _ProductCategoryState extends State<ProductCategory> {
  String selectedCategory = "";
  List<String> categoryList = <String>[];

  @override
  void initState() {
    super.initState();

    initCategoryLIst();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
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
                    '${widget.machineId + " Category"}',
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
                    screen: CategoryContents(
                  machineId: widget.machineId,
                  categoryId: "",
                ));
              },
              icon: Icon(Icons.add, size: 18),
              label: Text("Add"),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (String item in categoryList) (
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Text(
                              item,
                              style: semiBold.copyWith(
                                  fontSize: fontMd, color: Colors.black),
                            ),
                            Spacer(),
                            ElevatedButton.icon(
                              onPressed: () {
                                NavigatorService(context).pushToWidget(
                                    screen: CategoryContents(
                                  machineId: widget.machineId,
                                  categoryId: item
                                ));
                              },
                              icon: Icon(Icons.change_circle, size: 18),
                              label: Text("Change"),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                NavigatorService(context).pushToWidget(
                                    screen: ProductList(
                                  machineId: widget.machineId,
                                  categoryId: item
                                ));
                              },
                              icon: Icon(Icons.settings, size: 18),
                              label: Text("Products"),
                            ),
                          ],
                        ),
                      )),
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  void initCategoryLIst() {
    categoryList.clear();
    for (var item in categoryData) {
      categoryList.add(item);
    }
  }
}
