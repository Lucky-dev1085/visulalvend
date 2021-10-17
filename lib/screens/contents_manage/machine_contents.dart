import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:visualvend/utils/dimens.dart';
import 'package:visualvend/utils/themes.dart';
import 'package:image_picker/image_picker.dart';

class MachineContents extends StatefulWidget {
  final String machineId;

  const MachineContents({Key key, this.machineId}) : super(key: key);

  @override
  _MachineContentsState createState() => _MachineContentsState();
}

class _MachineContentsState extends State<MachineContents> {
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
              height: 52,
              // color: Colors.black,
              margin: EdgeInsets.only(top: 15),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Center(
                      child: Text(
                    '${widget.machineId == "" ? "Machine Add" : widget.machineId + " Change"}',
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
            Container(
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
                  // SizedBox(
                  //   height: 10.0,
                  // ),
                  // Text(
                  //   status,
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //     color: Colors.green,
                  //     fontWeight: FontWeight.w500,
                  //     fontSize: 20.0,
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20.0,
                  // ),
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
                            "Machine ID",
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
                            "Machine Location",
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
                            "Machine Site",
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
