import 'package:flutter/material.dart';
import 'package:visualvend/screens/chats/contact_us_screen.dart';
import 'package:visualvend/screens/chats/messaging_screen.dart';

class ProductChat extends StatefulWidget {
  const ProductChat({Key key, }) : super(key: key);
  @override
  _ProductChatState createState() => _ProductChatState();
}

class _ProductChatState extends State<ProductChat> {
  var pageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: pageIndex == 0 ? ContactUsScreen(onClickMenu: (menuIndex){
          setState(() {
            pageIndex = 1;
          });
        },
      )
      : MessageScreen(onClickCallCancel: (){
        setState(() {
          pageIndex = 0;
        });
      },),
    );
  }
}

