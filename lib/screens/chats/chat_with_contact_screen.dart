import 'package:flutter/material.dart';
import 'package:visualvend/utils/app_utils.dart';
import 'package:visualvend/utils/colors.dart';
import 'package:visualvend/utils/dimens.dart';
import 'package:visualvend/utils/themes.dart';
import 'package:visualvend/widgets/dropbox_widget.dart';
import 'package:visualvend/widgets/textfield_widget.dart';

class ChatWithUsScreen extends StatefulWidget {
  final String commentBody;
  final Function onBack;
  const ChatWithUsScreen({Key key, this.commentBody, this.onBack, }) : super(key: key);

  @override
  _ChatWithUsScreenState createState() => _ChatWithUsScreenState();
}

class _ChatWithUsScreenState extends State<ChatWithUsScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        backProcess();
        return false;
      },
      child: Container(
        width: double.infinity, height: double.infinity,
        padding: EdgeInsets.only(left: offsetMd, right: offsetMd, top: offsetBase, bottom: offsetSm),
        child: Container(),
        color: darkGreyColor,
      ),
    );
  }

  void backProcess() {
    widget.onBack();
  }
}

