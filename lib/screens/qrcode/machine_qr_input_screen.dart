import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:visualvend/utils/colors.dart';
import 'package:visualvend/utils/constants.dart';
import 'package:visualvend/utils/dimens.dart';
import 'package:visualvend/utils/themes.dart';
import 'package:visualvend/widgets/image_widget.dart';

// import 'package:qrscan/qrscan.dart' as scanner;

class MachineQRInputScreen extends StatefulWidget {
  final Function() onClickManualInput;
  final Function(String) onConnectToMachine;

  const MachineQRInputScreen({
    Key key,
    this.onClickManualInput,
    this.onConnectToMachine,
  }) : super(key: key);

  @override
  _CameraCaptureScreenState createState() => _CameraCaptureScreenState();
}

class _CameraCaptureScreenState extends State<MachineQRInputScreen> {
  var isFailedAlert = false;
  var isConnectingAlert = false;
  var isClickedCaptureAgain = true;
  var code = '12345';

  QRViewController controller;
  var result = '';
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void initState() {
    super.initState();
    delaySeconds();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      print("******************************");
      print(scanData.format);
      print(scanData.code);

      if (scanData.format == BarcodeFormat.qrcode && scanData.code != "") {
        setState(() {
          result = scanData.code;
        });
      }
    });
  }

  // Future _scanQR() async {
  //   try {
  //     String cameraScanResult = await scanner.scan();
  //     print("camera scan result =====  " + cameraScanResult);
  //     setState(() {
  //       code = cameraScanResult; // setting string result with cameraScanResult
  //     });
  //   } on PlatformException catch (e) {
  //     print("*****************");
  //     print(e);
  //   }
  // }

  delaySeconds() {
    Future.delayed(const Duration(milliseconds: 8000), () {
      
      setState(() {
        if (!isClickedCaptureAgain) {
          isClickedCaptureAgain = false;
          isFailedAlert = true;
          isConnectingAlert = false;
        }
        else if (result == '') {
          isClickedCaptureAgain = true;
          isFailedAlert = true;
          isConnectingAlert = false;
        } else {
          isFailedAlert = false;
          isConnectingAlert = true;
          Timer(Duration(milliseconds: 2000), () {
            widget.onConnectToMachine(code);
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: offsetBase, vertical: offsetLg),
      child: Column(
        children: [
          Text(
            'TO CONNECT TO MACHINE',
            style: boldText.copyWith(fontSize: fontXLg, color: Colors.white),
          ),
          SizedBox(
            height: offsetLg,
          ),
          Expanded(
              child: Stack(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(offsetBase),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(offsetBase)),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () => widget.onClickManualInput(),
                          child: IconWidget(
                            icon: 'assets/icons/ic_manul.svg',
                            iconType: ICONTYPE.Svg,
                            size: 44.0,
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          child: IconWidget(
                            icon: Icons.cancel_outlined,
                            iconType: ICONTYPE.IconData,
                            size: 44.0,
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: offsetBase,
                    ),
                    if(isFailedAlert)
                      Expanded(
                        child: Container(),
                      )
                    else
                      Expanded(
                        flex: 5,
                        child: QRView(
                          key: qrKey,
                          onQRViewCreated: _onQRViewCreated,
                          overlay: QrScannerOverlayShape(
                              borderColor: Colors.red,
                              borderRadius: 10,
                              borderLength: 30,
                              borderWidth: 10,
                              cutOutSize: 150.0),
                        ),
                      // child: Image.asset(
                      //   'assets/icons/ic_qr_temp.png',
                      //   fit: BoxFit.fitWidth,
                      // ),
                    )
                  ],
                ),
              ),
              if (isFailedAlert)
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 128.0,
                    margin: EdgeInsets.symmetric(horizontal: offsetBaseSm),
                    padding: EdgeInsets.symmetric(horizontal: offsetMd),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(offsetSm)),
                      color: lightYellowColor,
                    ),
                    child: Center(
                        child: Column(
                      children: [
                        Spacer(),
                        Text(
                          'Machine Not Found',
                          style: boldText.copyWith(
                              fontSize: fontXLg, color: textRedColor),
                        ),
                        Container(
                          height: 16,
                        ),
                        InkWell(
                          child: Text(
                            'Manual Input',
                            style: mediumText.copyWith(
                                fontSize: fontLg, color: textRedColor),
                          ),
                          onTap: () => widget.onClickManualInput(),
                        ),
                        Container(
                          width: 126,
                          height: 1,
                          color: textRedColor.withOpacity(0.7),
                        ),
                        Container(
                          height: 16,
                        ),
                        InkWell(
                          child: Text(
                            'Capture again',
                            style: mediumText.copyWith(
                                fontSize: fontLg, color: textRedColor),
                          ),
                          onTap: () {
                            setState(() {
                              isFailedAlert = false;
                              isClickedCaptureAgain = true;
                              delaySeconds();
                            });
                          },
                        ),
                        Container(
                          width: 126,
                          height: 1,
                          color: textRedColor.withOpacity(0.7),
                        ),
                        Spacer(),
                      ],
                    )),
                  ),
                ),
              if (isConnectingAlert && result != '')
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 100.0,
                    padding: EdgeInsets.symmetric(horizontal: offsetMd),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(offsetSm)),
                      color: lightGreyColor,
                    ),
                    child: Column(
                      children: [
                        Spacer(),
                        Text(
                          'CONNECTING TO SITE 12',
                          style: boldText.copyWith(fontSize: fontXLg),
                        ),
                        SizedBox(
                          height: offsetXSm,
                        ),
                        Text(
                          'Westfields Mail Chatswood Level 3',
                          style: mediumText.copyWith(fontSize: fontMd),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
            ],
          )),
          SizedBox(
            height: offsetLg,
          ),
          Text(
            'CENTER QR CODE TO AUTO\nCAPTURE & CONNECT',
            style: boldText.copyWith(fontSize: fontXLg, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
