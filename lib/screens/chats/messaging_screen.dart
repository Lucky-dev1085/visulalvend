import 'package:flutter/material.dart';
import 'package:visualvend/utils/app_utils.dart';
import 'package:visualvend/utils/colors.dart';
import 'package:visualvend/utils/dimens.dart';
import 'package:visualvend/utils/themes.dart';
import 'package:visualvend/widgets/dropbox_widget.dart';
import 'package:visualvend/widgets/textfield_widget.dart';

class MessageScreen extends StatefulWidget {
  final Function onClickCallCancel;
  final Function(String) onClickStartChat;
  const MessageScreen({Key key, this.onClickCallCancel, this.onClickStartChat, }) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  List<String> spMachineIds, spProducts, spEnquiryType;
  var selectedMachine, selectedProduct, selectedEnquiry;

  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtFeedback = TextEditingController();
  var username = '', phoneNumber = '', email = '', feedback;

  @override
  void initState() {
    super.initState();

    spMachineIds = <String>[];
    spMachineIds.add('Machine IDs');
    for(int i=1; i < 10; i++){
      spMachineIds.add('Machine ' + i.toString());
    }
    selectedMachine = spMachineIds.elementAt(0);

    spProducts = <String>[];
    spProducts.add('Products');
    for(int i=1; i < 10; i++){
      spProducts.add('Product ' + i.toString());
    }
    selectedProduct = spProducts.elementAt(0);

    spEnquiryType = <String>[];
    spEnquiryType.add('Enquiry Types');
    for(int i=1; i < 10; i++){
      spEnquiryType.add('Enquiry Type ' + i.toString());
    }
    selectedEnquiry = spEnquiryType.elementAt(0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, height: double.infinity,
      padding: EdgeInsets.only(left: offsetMd, right: offsetMd, top: offsetBase, bottom: offsetSm),
      child: Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Center(child: Text('CONTACT US - CHAT', style: semiBold.copyWith(fontSize: font24Lg, color: Colors.white),)),
              ),
              Container(
                margin: EdgeInsets.only(top: offsetBaseSm),
                child: Center(child: Text('please provide details so we can assist you.', style: semiBold.copyWith(fontSize: fontBase, color: Colors.white),)),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: offsetBaseSm),
                child: DropDownWidget(
                  spinnerItems: spMachineIds,
                  selectedText: selectedMachine,
                  backColor: Colors.white,
                  isExpanded: true,
                  onChanged: (val) => {
                    setState((){
                      selectedMachine = val;
                    })
                  },
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: offsetBaseSm),
                child: DropDownWidget(
                  spinnerItems: spProducts,
                  selectedText: selectedProduct,
                  backColor: Colors.white,
                  isExpanded: true,
                  onChanged: (val) => {
                    setState((){
                      selectedProduct = val;
                    })
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: offsetBase, ),
                padding: EdgeInsets.symmetric(horizontal: offsetSm),
                child: NoOutLineTextField(controller: txtUsername, hint: 'Name', textSize: fontSm, keyboardType: TextInputType.text,),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(offsetXXSm)),
                  color: Colors.white,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: offsetBase, ),
                padding: EdgeInsets.symmetric(horizontal: offsetSm),
                child: NoOutLineTextField(controller: txtPhone, hint: 'Phone number', textSize: fontSm, keyboardType: TextInputType.phone,),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(offsetXXSm)),
                  color: Colors.white,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: offsetBase, ),
                padding: EdgeInsets.symmetric(horizontal: offsetSm),
                child: NoOutLineTextField(controller: txtEmail, hint: 'Email', textSize: fontSm, keyboardType: TextInputType.emailAddress,),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(offsetXXSm)),
                  color: Colors.white,
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: offsetBaseSm),
                child: DropDownWidget(
                  spinnerItems: spEnquiryType,
                  selectedText: selectedEnquiry,
                  backColor: Colors.white,
                  isExpanded: true,
                  onChanged: (val) => {
                    setState((){
                      selectedEnquiry = val;
                    })
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: offsetBase, ),
                padding: EdgeInsets.symmetric(horizontal: offsetSm, ),
                child: NoOutLineTextField(controller: txtFeedback, hint: 'Comment (type manually)', textSize: fontSm, keyboardType: TextInputType.text,),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(offsetXXSm)),
                  color: Colors.white,
                ),
                height: 120,
              ),
              SizedBox(height: offsetBase,),
              Row(
                children: [
                  Container(
                    child: InkWell(
                      child: Column(
                        children: [
                          Container(child: Text('CANCEL', style: semiBold.copyWith(fontSize: fontLg, color: Colors.white),),),
                          Container(width: 80, height: 1, color: Colors.white,),
                        ],
                      ),
                      onTap: (){
                        widget.onClickCallCancel();
                      },
                    ),
                  ),
                  Spacer(),
                  Container(
                    child: InkWell(
                      child: Column(
                        children: [
                          Container(child: Text('START CHAT', style: semiBold.copyWith(fontSize: fontLg, color: Colors.white),),),
                          Container(width: 120, height: 1, color: Colors.white,),
                        ],
                      ),
                      onTap: (){
                        onClickedSendMessage();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: offsetBaseSm,),
            ],
          ),
        ),
      ),
      color: darkGreyColor,
    );
  }

  onClickedSendMessage() {
    String checkSendMsg = checkSendMessage();
    if(checkSendMsg == ''){
      widget.onClickStartChat(txtFeedback.text);
    }else{
      showToast('Please fill below options.');
    }
  }

  String checkSendMessage() {
    if(selectedMachine == 'Machine IDs'){
      return 'Please select Machine ID.';
    }else if(selectedProduct == 'Products'){
      return 'Please select product.';
    }else if(selectedEnquiry == 'Enquiry Types'){
      return 'Please select enquiry type.';
    }else if(txtUsername.text == ''){
      return 'Please enter name.';
    }else if(txtPhone.text == ''){
      return 'Please enter your phone number.';
    }else if(txtEmail.text == ''){
      return 'Please enter your email.';
    }else if(txtFeedback.text == ''){
      return 'Please write your comment.';
    }
    return '';
  }
}

