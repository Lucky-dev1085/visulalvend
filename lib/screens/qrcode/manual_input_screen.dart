import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:visualvend/utils/app_utils.dart';
import 'package:visualvend/utils/colors.dart';
import 'package:visualvend/utils/dimens.dart';
import 'package:visualvend/utils/params.dart';
import 'package:visualvend/utils/themes.dart';
import 'package:visualvend/widgets/textfield_widget.dart';

class ManualInputScreen extends StatefulWidget {
  final Function() onClickQRScan;
  final Function(String) onClickOkKeypad;

  const ManualInputScreen({Key key, @required this.onClickQRScan, this.onClickOkKeypad})
      : super(key: key);

  @override
  _ManualInputScreenState createState() => _ManualInputScreenState();
}

class _ManualInputScreenState extends State<ManualInputScreen> {
  var controller = TextEditingController();
  var isFavoriteCheck = false;
  var code = '12345';

  _addText(String str) {
    if (str == 'OK') {
      if(!controller.text.isNotEmpty){
        showToast('Please enter machine ID.');
      }else{
        widget.onClickOkKeypad(code);
      }
    } else {
      String inputValue = controller.text;
      String newStr = inputValue + str;
      setState(() {
        controller.text = newStr;
      });
    }
  }

  _backspace() {
    String inputValue = controller.text;
    if (inputValue.isNotEmpty) {
      String newStr = inputValue.substring(0, inputValue.length - 1);
      setState(() {
        controller.text = newStr;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: offsetBase, vertical: 26),
          child: Column(
            children: [
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'VEND MACHINE',
                      style: boldText.copyWith(fontSize: fontXXLg, color: Colors.white)
                    ),
                    TextSpan(
                      text: ' NOT FOUND',
                      style: boldText.copyWith(fontSize: fontXXLg, color: selectedColor)
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: offsetLg,
              ),
              Container(
                width: double.infinity,
                height: 52.0,
                padding: EdgeInsets.symmetric(horizontal: offsetBase, vertical: offsetSm),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => widget.onClickQRScan(),
                      child: Icon(MdiIcons.creditCardScan)
                    ),
                    SizedBox(
                      width: offsetBase,
                    ),
                    Expanded(
                      child: NoOutLineTextField(
                        controller: controller,
                        keyboardType: null,
                        hint: 'Please Enter Machine ID Number Below',
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        textAlign: TextAlign.center,
                      )
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(offsetSm),
                  ),
                ),
              ),
              SizedBox(
                height: 28,
              ),
              Expanded(
                child: Column(
                children: [
                  for (var keyRow in keyBoards) Expanded(
                    child: Row(
                      children: [
                        for (var key in keyRow) Expanded(
                          child: Center(
                            child: key['type'] == 'Text' ?
                              InkWell(
                                onTap: () => _addText(key['title']),
                                child: Container(
                                  width: 56.0,
                                  height: 56.0,
                                  child: Center(
                                    child: Text(
                                      key['title'],
                                      style: boldText.copyWith(
                                          fontSize: 22.0),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(56.0 / 2)),
                                  ),
                                ),
                              ) :
                              InkWell(
                                onTap: () => _backspace(),
                                child: Container(
                                  width: 56.0,
                                  height: 56.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(56.0 / 2)),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      key['title'],
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          if(controller.text.isNotEmpty){
                            isFavoriteCheck = !isFavoriteCheck;
                          }else{
                            showToast('Please enter mechine ID.');
                          }
                        });
                      },
                      child: Row(
                        children: [
                          Icon(
                            isFavoriteCheck ? Icons.check_box : Icons.check_box_outline_blank,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: offsetBase,
                          ),
                          Text(
                            'Add Machine to Favourites',
                            style: semiBold.copyWith(fontSize: 16.0, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    'Help',
                    style: boldText.copyWith(fontSize: 16.0, color: selectedColor),
                  ),
                  SizedBox(
                    width: offsetBase,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
