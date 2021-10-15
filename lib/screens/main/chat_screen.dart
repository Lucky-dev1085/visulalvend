import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visualvend/models/vend_history_model.dart';
import 'package:visualvend/screens/chats/chat_with_contact_screen.dart';
import 'package:visualvend/screens/chats/contact_us_screen.dart';
import 'package:visualvend/screens/chats/messaging_screen.dart';
import 'package:visualvend/screens/vendHistory/all_history_screen.dart';
import 'package:visualvend/screens/vendHistory/view_history_screen.dart';
import 'package:visualvend/utils/app_utils.dart';
import 'package:visualvend/utils/colors.dart';
import 'package:visualvend/utils/dimens.dart';
import 'package:visualvend/utils/themes.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key key, }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var pageIndex = 0;
  var feedback = '';

  getWindow(){
    switch(pageIndex){
      case 0:
        return ContactUsScreen(onClickMenu: (menuIndex){
            setState(() {
              pageIndex = 1;
            });
          },
        );
      case 1:
        return MessageScreen(onClickCallCancel: (){
            setState(() {
              pageIndex = 0;
            });
          },
          onClickStartChat: (_feedback){
            setState(() {
              feedback = _feedback;
              pageIndex = 2;
            });
          },
        );
      case 2:
        return ChatWithUsScreen(commentBody: feedback, onBack: (){
            setState(() {
              pageIndex = 0;
            });
          },
        );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: getWindow(),
    );
  }
}



