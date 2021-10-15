import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:visualvend/utils/app_utils.dart';
import 'package:visualvend/utils/colors.dart';
import 'package:visualvend/utils/constants.dart';
import 'package:visualvend/utils/dimens.dart';
import 'package:visualvend/utils/sharedpref.dart';
import 'package:visualvend/widgets/textfield_widget.dart';

import 'image_widget.dart';

class SearchAreaWidget extends StatelessWidget {
  final String selectedFilterVal;
  final TextEditingController txtController;
  final List<String> spSearchList;
  final Function(String) onClickSearch;
  final Function(String) onChangedSpinner;
  final Function onClickQRInput;

  const SearchAreaWidget({Key key, this.onClickSearch, this.onChangedSpinner, this.onClickQRInput, this.spSearchList, this.selectedFilterVal, this.txtController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchType = SharedPrefs.getInt(SharedPrefs.KEY_SEARCH_TYPE);

    return Container(
      child: Row(children: [
          Expanded(child: Container(
              height: 43, width: screenWidth,
              margin: EdgeInsets.only(left: 8),
              padding: EdgeInsets.only(bottom: searchType == 1 ? 0 : 6),
              child: Row(children: [
                SizedBox(width: offsetMSm, ),
                searchType == 1 ? InkWell(
                  child: IconWidget(
                    icon: Icons.qr_code_2,
                    iconType: ICONTYPE.IconData,
                    color: darkGreyColor,
                    size: 32.0,
                  ),
                  onTap: (){
                    onClickQRInput();
                  },)
                // : DropDownWidget(
                //   spinnerItems: spSearchList,
                //   selectedText: selectedFilterVal,
                //   backColor: Colors.white,
                //   isExpanded: true,
                //   onChanged: (val) {
                //     onChangedSpinner(val);
                //   },
                // ),
                  : Container(
                    margin: EdgeInsets.only(left: 6, top: 4),
                    child: DropdownButton<String>(
                      items: spSearchList.map((String _value) {
                        return DropdownMenuItem<String>(
                          value: _value,
                          child: Text(_value, style: TextStyle(color: Colors.black, fontSize: fontBase),),
                        );
                      }).toList(),
                      value: selectedFilterVal,
                      isExpanded: false,
                      style: TextStyle(color: Colors.black, fontSize: fontXSm,),
                      underline: Container(
                        height: 1,
                        color: Colors.transparent,
                      ),
                      onChanged: (val) {
                        onChangedSpinner(val);
                      },
                    ),
                  ),
                  Expanded(child: Container(
                    height: 40, alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 6, bottom: 8),
                    child: NoOutLineTextField(controller: txtController, textSize: 14, keyboardType: TextInputType.text, hint: 'Please fill search field.', hintColor: Colors.grey.withOpacity(0.7),),
                  )),
              ],
            ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(offsetSm)),
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: offsetSm,),
          InkWell(
            child: IconWidget(
              icon: Icons.search,
              iconType: ICONTYPE.IconData,
              size: 32.0,
              color: Colors.white,
            ),
            onTap: (){
              if(txtController.text == ''){
                showToast('Please fill text field');
              }else{
                onClickSearch(txtController.text);
              }
            },
          ),
          SizedBox(width: offsetSm,),
        ],
      ),
      height: 54.0,
      margin: EdgeInsets.only(left: offsetBase, right: offsetBase, ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(offsetSm)),
        color: normalGreyColor,
      ),
    );
  }
}