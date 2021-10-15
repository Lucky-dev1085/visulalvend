import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visualvend/utils/colors.dart';
import 'package:visualvend/utils/dimens.dart';
import 'package:visualvend/utils/themes.dart';

class ContactUsScreen extends StatefulWidget {
  final Function(int) onClickMenu;
  const ContactUsScreen({Key key, this.onClickMenu, }) : super(key: key);
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, height: double.infinity,
      padding: EdgeInsets.only(left: offsetMd, right: offsetMd, top: offsetXMd, bottom: offsetSm),
      child: Column(
        children: [
          Container(
            child: Center(child: Text('FEEDBACK / CHAT MENU', style: semiBold.copyWith(fontSize: font24Lg, color: Colors.white),)),
          ),
          Expanded(child: Container(
            child: Column(
              children: [
                Spacer(),
                InkWell(
                  child: Container(
                    width: double.infinity, height: 78,
                    child: Row(
                      children: [
                        Container(
                          width: 44, height: 44,
                          padding: EdgeInsets.all(4),
                          margin: EdgeInsets.only(left: 12, right: 8),
                          child: Image.asset('assets/icons/ic_msg.png', width: 32,),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(22)),
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 6, right: 6, top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Feedback', style: semiBold.copyWith(fontSize: fontLg, color: Colors.white)),
                                SizedBox(height: 6,),
                                Text('Reopening issues with stock. Machine not working or damage.', style: semiBold.copyWith(fontSize: fontSm, color: Colors.white), maxLines: 2,),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(offsetMSm)),
                      color: normalGreyColor,
                    ),
                  ),
                  onTap: (){
                    onSendFeedback(getUrl('Feedback', 'Reopening issues with vending product, payment not working as described.'));
                  },
                ),
                SizedBox(height: 32,),
                InkWell(
                  child: Container(
                    width: double.infinity, height: 78,
                    child: Row(
                      children: [
                        Container(
                          width: 44, height: 44,
                          padding: EdgeInsets.all(2),
                          margin: EdgeInsets.only(left: 12, right: 8),
                          child: Image.asset('assets/icons/ic_close.png', width: 34,),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(22)),
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 6, right: 6, top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Issues Vending', style: semiBold.copyWith(fontSize: fontLg, color: Colors.white)),
                                SizedBox(height: 6,),
                                Text('Reopening issues with vending product, payment not working as described.', style: semiBold.copyWith(fontSize: fontSm, color: Colors.white), maxLines: 2,),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(offsetMSm)),
                      color: normalGreyColor,
                    ),
                  ),
                  onTap: (){
                    onSendFeedback(getUrl('Issues Vending', 'Reopening issues with vending product, payment not working as described.'));
                  },
                ),
                Spacer(),
              ],
            ),
            ), ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: offsetBase),
            child: Row(
              children: [
                InkWell(
                  child: Container(
                    width: 68, height: 68,
                    child: Column(
                      children: [
                        Image.asset('assets/icons/ic_msg1.png', width: 44, color: Colors.white,),
                        Text('CHAT', style: semiBold.copyWith(fontSize: fontBase, color: Colors.white)),
                      ],
                    ),
                  ),
                  onTap: (){
                    onChat();
                  },
                ),
                Spacer(),
                InkWell(
                  child: Container(
                    width: 68, height: 68,
                    child: Column(
                      children: [
                        Image.asset('assets/icons/ic_share.png', width: 44, color: Colors.white,),
                        Text('SHARE', style: semiBold.copyWith(fontSize: fontBase, color: Colors.white)),
                      ],
                    ),
                  ),
                  onTap: (){
                    onShareAppLink();
                  },
                ),
                Spacer(),
                InkWell(
                  child: Container(
                    width: 68, height: 68,
                    child: Column(
                      children: [
                        Icon(Icons.call, size: 44, color: Colors.white,),
                        Text('CALL', style: semiBold.copyWith(fontSize: fontBase, color: Colors.white)),
                      ],
                    ),
                  ),
                  onTap: (){
                    onCallNumber();
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: offsetMSm,),
        ],
      ),
      color: darkGreyColor,
    );
  }

  onShareAppLink(){
    Share.share('Please view this app on this link, https://play.google.com/store/apps/details?id=idhere');
  }

  onCallNumber() async{
    const phoneNumber = 'tel:+856 209 622 7257';
    await launch(phoneNumber);
  }

  void onChat() {
    widget.onClickMenu(1);
  }

  Future<void> onSendFeedback(String feedbackBody) async {
    await launch(feedbackBody);
  }

  String getUrl(String subject, String body) {
    String url = 'mailto:imadehimviral@gmail.com?';
    url += 'subject=$subject&';
    url += 'body=$body&';
    return url;
  }
}

