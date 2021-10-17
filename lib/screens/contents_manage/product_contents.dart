import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:visualvend/utils/colors.dart';
import 'package:visualvend/utils/dimens.dart';
import 'package:visualvend/utils/themes.dart';

enum ProductStatus { active, suspended, recalled }
enum AgeIDRequired { yes, no, someitems }

class ProductContents extends StatefulWidget {
  final String machineId;
  final String categoryId;
  final String productId;

  const ProductContents(
      {Key key, this.machineId, this.categoryId, this.productId})
      : super(key: key);

  @override
  _ProductContentsState createState() => _ProductContentsState();
}

class _ProductContentsState extends State<ProductContents> {
  ProductStatus _selStatus = ProductStatus.active;
  AgeIDRequired _selAgeRequired = AgeIDRequired.yes;

  Future<PickedFile> file;
  String status = '';
  String base64Image;
  PickedFile tmpFile;
  String errMessage = 'Error Uploading Image';
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  chooseImage() {
    setState(() {
      file = _picker.getImage(source: ImageSource.gallery);
      status = '';
    });
  }

  Widget showImage() {
    return FutureBuilder<PickedFile>(
      future: file,
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot<PickedFile> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image =
              base64Encode(File(snapshot.data.path).readAsBytesSync());
          return Image.file(
            File(snapshot.data.path),
            height: 150,
            fit: BoxFit.fitHeight,
            // ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  startUpload() {
    setState(() {
      status = 'Uploading Image...';
    });
    if (null == tmpFile) {
      setState(() {
        status = errMessage;
      });
      return;
    }
    String fileName = tmpFile.path.split('/').last;
    upload(fileName);
  }

  upload(String fileName) {
    // http.post(uploadEndPoint, body: {
    //   "image": base64Image,
    //   "name": fileName,
    // }).then((result) {
    //   setStatus(result.statusCode == 200 ? result.body : errMessage);
    // }).catchError((error) {
    //   setStatus(error);
    // });
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
              height: 70,
              // color: Colors.black,
              margin: EdgeInsets.only(top: 15),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Center(
                      child: Text(
                    '${widget.machineId + " / " + widget.categoryId + " / " + (widget.productId == "" ? " Product Add" : widget.productId + " Change")}',
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
            Expanded(
                child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          OutlinedButton(
                            onPressed: chooseImage,
                            child: Text('Choose Image'),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          showImage(),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            "Product Location",
                            style: semiBold.copyWith(
                                fontSize: fontMd, color: Colors.black),
                          ),
                          Spacer(),
                          Text(
                            "01",
                            style: semiBold.copyWith(
                                fontSize: fontMd, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            "Product ID",
                            style: semiBold.copyWith(
                                fontSize: fontMd, color: Colors.black),
                          ),
                          Spacer(),
                          Text(
                            "LDMXOID",
                            style: semiBold.copyWith(
                                fontSize: fontMd, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            "Product SKU#",
                            style: semiBold.copyWith(
                                fontSize: fontMd, color: Colors.black),
                          ),
                          Spacer(),
                          Text(
                            "sadfasesd",
                            style: semiBold.copyWith(
                                fontSize: fontMd, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            "Product Classification/No#",
                            style: semiBold.copyWith(
                                fontSize: fontMd, color: Colors.black),
                          ),
                          Spacer(),
                          Text(
                            "0123456789",
                            style: semiBold.copyWith(
                                fontSize: fontMd, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            "Product Classification",
                            style: semiBold.copyWith(
                                fontSize: fontMd, color: Colors.black),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            "Product Grading",
                            style: semiBold.copyWith(
                                fontSize: fontMd, color: Colors.black),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            "Product Status",
                            style: semiBold.copyWith(
                                fontSize: fontMd, color: Colors.black),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Column(children: <Widget>[
                            RadioListTile<ProductStatus>(
                              contentPadding: EdgeInsets.all(0),
                              title: const Text('Active'),
                              value: ProductStatus.active,
                              groupValue: _selStatus,
                              onChanged: (ProductStatus value) {
                                setState(() {
                                  _selStatus = value;
                                });
                              },
                            ),
                            RadioListTile<ProductStatus>(
                              contentPadding: EdgeInsets.all(0),
                              title: const Text('Suspended'),
                              value: ProductStatus.suspended,
                              groupValue: _selStatus,
                              onChanged: (ProductStatus value) {
                                setState(() {
                                  _selStatus = value;
                                });
                              },
                            ),
                            RadioListTile<ProductStatus>(
                              contentPadding: EdgeInsets.all(0),
                              title: const Text('Recalled'),
                              value: ProductStatus.recalled,
                              groupValue: _selStatus,
                              onChanged: (ProductStatus value) {
                                setState(() {
                                  _selStatus = value;
                                });
                              },
                            ),
                          ]))
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            "Product Name",
                            style: semiBold.copyWith(
                                fontSize: fontMd, color: Colors.black),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            "Product Caption",
                            style: semiBold.copyWith(
                                fontSize: fontMd, color: Colors.black),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            "Product Size",
                            style: semiBold.copyWith(
                                fontSize: fontMd, color: Colors.black),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            "Product Max Qty",
                            style: semiBold.copyWith(
                                fontSize: fontMd, color: Colors.black),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          CustomNumberPicker(
                            initialValue: 0,
                            maxValue: 1000000,
                            minValue: 0,
                            step: 1,
                            onValue: (value) {
                              print(value.toString());
                            },
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            "Product Aisle Actual Qty",
                            style: semiBold.copyWith(
                                fontSize: fontMd, color: Colors.black),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          CustomNumberPicker(
                            initialValue: 0,
                            maxValue: 1000000,
                            minValue: 0,
                            step: 1,
                            onValue: (value) {
                              print(value.toString());
                            },
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            "Machine Total Same Item Qty",
                            style: semiBold.copyWith(
                                fontSize: fontMd, color: Colors.black),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            "Product Sell Price",
                            style: semiBold.copyWith(
                                fontSize: fontMd, color: Colors.black),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            "Age ID Required?",
                            style: semiBold.copyWith(
                                fontSize: fontMd, color: Colors.black),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Column(children: <Widget>[
                            RadioListTile<AgeIDRequired>(
                              contentPadding: EdgeInsets.all(0),
                              title: const Text('Yes'),
                              value: AgeIDRequired.yes,
                              groupValue: _selAgeRequired,
                              onChanged: (AgeIDRequired value) {
                                setState(() {
                                  _selAgeRequired = value;
                                });
                              },
                            ),
                            RadioListTile<AgeIDRequired>(
                              contentPadding: EdgeInsets.all(0),
                              title: const Text('No'),
                              value: AgeIDRequired.no,
                              groupValue: _selAgeRequired,
                              onChanged: (AgeIDRequired value) {
                                setState(() {
                                  _selAgeRequired = value;
                                });
                              },
                            ),
                            RadioListTile<AgeIDRequired>(
                              contentPadding: EdgeInsets.all(0),
                              title: const Text('SomeItems'),
                              value: AgeIDRequired.someitems,
                              groupValue: _selAgeRequired,
                              onChanged: (AgeIDRequired value) {
                                setState(() {
                                  _selAgeRequired = value;
                                });
                              },
                            ),
                          ]))
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            "ProductSpacetoSales",
                            style: semiBold.copyWith(
                                fontSize: fontMd, color: Colors.black),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            "ProductS2S Sequence",
                            style: semiBold.copyWith(
                                fontSize: fontMd, color: Colors.black),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            "Product SpacetoSales Method",
                            style: semiBold.copyWith(
                                fontSize: fontMd, color: Colors.black),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            "Product SpacetoSales Start",
                            style: semiBold.copyWith(
                                fontSize: fontMd, color: Colors.black),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(),
                            ),
                          )
                        ],
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Respond to button press
                      },
                      icon: Icon(Icons.save, size: 18),
                      label: Text("SAVE"),
                    )
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
