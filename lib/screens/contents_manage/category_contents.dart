import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:visualvend/utils/dimens.dart';
import 'package:visualvend/utils/themes.dart';

class CategoryContents extends StatefulWidget {
  final String machineId;
  final String categoryId;

  const CategoryContents({Key key, this.machineId, this.categoryId}) : super(key: key);

  @override
  _CategoryContentsState createState() => _CategoryContentsState();
}

class _CategoryContentsState extends State<CategoryContents> {

  @override
  void initState() {
    super.initState();
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
                    '${widget.categoryId == "" ? "Category Add" : widget.categoryId + " Change"}',
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
                      margin: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            "Category Name",
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
