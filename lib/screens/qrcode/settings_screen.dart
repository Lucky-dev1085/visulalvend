import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:visualvend/screens/contents_manage/machine_contents.dart';
import 'package:visualvend/screens/contents_manage/product_category.dart';
import 'package:visualvend/screens/contents_manage/product_list.dart';
import 'package:visualvend/services/navigator_service.dart';
import 'package:visualvend/utils/colors.dart';
import 'package:visualvend/utils/dimens.dart';
import 'package:visualvend/utils/sharedpref.dart';
import 'package:visualvend/utils/themes.dart';
import 'package:visualvend/widgets/dropbox_widget.dart';

class SettingsScreen extends StatefulWidget {
  final Function onCallback;
  final Function onChangeSearchOption;
  final Function(int) onClickBackHome;

  const SettingsScreen({
    Key key,
    this.onCallback,
    this.onChangeSearchOption,
    this.onClickBackHome,
  }) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<String> spSettingsSearch = <String>[];
  List<String> spPreferenceDisp = <String>[];
  List<String> spMachineList = <String>[];
  List<String> spProductMachineList = <String>[];
  var selectedSearchOption = '';
  var selectedDisp = '';
  var searchType = 0;
  var selectedMachine = '';
  var selectedProductMachine = '';

  @override
  void initState() {
    super.initState();

    spSettingsSearch.clear();
    spSettingsSearch.add('Search by Filters List');
    spSettingsSearch.add('Quick Search');

    searchType = SharedPrefs.getInt(SharedPrefs.KEY_SEARCH_TYPE);
    selectedSearchOption = spSettingsSearch.elementAt(searchType);

    spPreferenceDisp.clear();
    spPreferenceDisp.add('Horizontally');
    spPreferenceDisp.add('Vertically');
    spPreferenceDisp.add('Complex Style');
    selectedDisp = spPreferenceDisp.elementAt(0);

    spMachineList.clear();
    spProductMachineList.clear();
    for (int i = 1; i < 13; i++) {
      spMachineList.add('Site ' + i.toString());
      spProductMachineList.add('Site ' + i.toString());
    }
    selectedMachine = spMachineList.elementAt(0);
    selectedProductMachine = spProductMachineList.elementAt(0);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: darkGreyColor,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 52,
            color: darkGreyColor,
            margin: EdgeInsets.only(top: 8),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Center(
                    child: Text(
                  'Settings',
                  style: semiBold.copyWith(
                      fontSize: 26,
                      color: Colors.white,
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
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {
                        widget.onCallback();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 26,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 22, vertical: 12),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Search Options',
                      style: semiBold.copyWith(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 48,
                      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                      child: DropDownWidget(
                        spinnerItems: spSettingsSearch,
                        selectedText: selectedSearchOption,
                        backColor: Colors.white,
                        isExpanded: true,
                        onChanged: (val) => {changeSearchOption(val)},
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Menu Preferences  Options',
                      style: semiBold.copyWith(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 48,
                      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                      child: DropDownWidget(
                        spinnerItems: spPreferenceDisp,
                        selectedText: selectedDisp,
                        backColor: Colors.white,
                        isExpanded: true,
                        onChanged: (val) => {changeDispPref(val)},
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Wallet Option',
                      style: semiBold.copyWith(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 52,
                      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 12,
                          ),
                          Icon(
                            Icons.monetization_on,
                            size: 38,
                            color: Colors.black.withOpacity(0.8),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            'Linked Account',
                            style: semiBold.copyWith(
                              fontSize: 16,
                              color: Colors.black.withOpacity(0.85),
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 23,
                            color: Colors.black.withOpacity(0.8),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(offsetSm)),
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Cart Option',
                      style: semiBold.copyWith(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 52,
                      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 12,
                          ),
                          Badge(
                            badgeContent: Text(
                              '3',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            child: Icon(
                              Icons.shopping_cart_outlined,
                              size: 34,
                              color: getFocusColor(1, 1),
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            'Your Cart',
                            style: semiBold.copyWith(
                              fontSize: 16,
                              color: Colors.black.withOpacity(0.85),
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 23,
                            color: Colors.black.withOpacity(0.8),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(offsetSm)),
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Machine Setting',
                      style: semiBold.copyWith(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                        width: double.infinity,
                        height: 48,
                        margin:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                        child: Row(
                          children: [
                            Expanded(
                                child: DropDownWidget(
                              spinnerItems: spMachineList,
                              selectedText: selectedMachine,
                              backColor: Colors.white,
                              isExpanded: true,
                              onChanged: (val) => {changeMachine(val)},
                            )),
                            Spacer(),
                            ElevatedButton.icon(
                              onPressed: () {
                                NavigatorService(context).pushToWidget(
                                    screen: MachineContents(
                                  machineId: "",
                                ));
                              },
                              icon: Icon(Icons.add, size: 18),
                              label: Text("Add"),
                            ),
                            SizedBox(width: 10,),
                            ElevatedButton.icon(
                              onPressed: () {
                                NavigatorService(context).pushToWidget(
                                    screen: MachineContents(
                                  machineId: selectedMachine,
                                ));
                              },
                              icon: Icon(Icons.change_circle, size: 18),
                              label: Text("Change"),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Product Setting',
                      style: semiBold.copyWith(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                        width: double.infinity,
                        height: 48,
                        margin:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                        child: Row(
                          children: [
                            Expanded(
                                child: DropDownWidget(
                              spinnerItems: spProductMachineList,
                              selectedText: selectedProductMachine,
                              backColor: Colors.white,
                              isExpanded: true,
                              onChanged: (val) => {changeProductMachine(val)},
                            )),
                            Spacer(),
                            ElevatedButton.icon(
                              onPressed: () {
                                NavigatorService(context).pushToWidget(
                                    screen: ProductCategory(
                                  machineId: selectedProductMachine,
                                ));
                              },
                              icon: Icon(Icons.settings, size: 18),
                              label: Text("Set"),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  changeSearchOption(String val) {
    searchType = spSettingsSearch.indexOf(val);
    SharedPrefs.saveInt(SharedPrefs.KEY_SEARCH_TYPE, searchType);

    setState(() {
      selectedSearchOption = val;
    });
    widget.onChangeSearchOption();
  }

  changeDispPref(val) {
    setState(() {
      selectedDisp = val;
    });
  }

  changeMachine(val) {
    setState(() {
      selectedMachine = val;
    });
  }

  changeProductMachine(val) {
    setState(() {
      selectedProductMachine = val;
    });
  }
}
