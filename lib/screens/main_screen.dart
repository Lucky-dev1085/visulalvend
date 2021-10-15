import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visualvend/screens/main/home_screen.dart';
import 'package:visualvend/screens/qrcode/qr_scan_screen.dart';
import 'package:visualvend/screens/search/search_screen.dart';
import 'package:visualvend/services/navigator_service.dart';
import 'package:visualvend/utils/app_utils.dart';
import 'package:visualvend/utils/colors.dart';
import 'package:visualvend/utils/dimens.dart';
import 'package:visualvend/utils/params.dart';
import 'package:visualvend/utils/sharedpref.dart';
import 'package:visualvend/utils/themes.dart';
import 'package:visualvend/widgets/image_widget.dart';
import 'package:visualvend/widgets/search_widget.dart';

import 'main/chat_screen.dart';
import 'main/favorite_screen.dart';
import 'main/nearest_vendmachine_screen.dart';
import 'main/vend_history_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  var bottomIndex = 2;
  var searchType = 0;
  var selectedSpVal = 'Products';
  var showSearch = false;
  var selectedFilterVal;
  var searchKey = '';
  var preBottomIndex;

  List<String> spSearchList = <String>[];
  TextEditingController txtController = TextEditingController();

  getWindows(){
    switch(bottomIndex){
      case 0:
        return FavoriteScreen(onClickBackHome: (_index){
          gotoOtherPages(_index);
        },);
      case 1:
        return VendHistoryScreen(onClickBackHome: (index){
            gotoOtherPages(index);
          },
        );
      case 2:
        return HomeScreen(scaffoldKey: scaffoldKey, onClickBackHome: (index){
            searchType = SharedPrefs.getInt(SharedPrefs.KEY_SEARCH_TYPE);
            gotoOtherPages(index);
          },
          onChangeSearchOption: (){
            setState(() {
              searchType = SharedPrefs.getInt(SharedPrefs.KEY_SEARCH_TYPE);
            });
          },
        );
      case 3:
        return NearestVendMachineScreen(onClickBackHome: (index){
            gotoOtherPages(index);
          },
        );
      case 4:
        return ChatScreen();
      case 5:
        return SearchScreen(title: 'Search Result', searchCategory: searchType == 0 ? selectedSpVal : 'Quick Search'
          , willPopUpProduct: true, searchKey: searchKey, onclickBack: (){
            setState(() {
              bottomIndex = preBottomIndex;
            });
          },
        );
    }
  }

  @override
  void initState() {
    super.initState();
    initAppData();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height - topBarHeight - bottomBarHeight - statusBarHeight;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          toolbarHeight: topBarHeight,
          title: Center(child: Text('MEDIA AD PLAYS', style: semiBold.copyWith(fontSize: 18.0),)),
          backgroundColor: Colors.white,
        ),
        body: mainBody(),
        bottomNavigationBar: bottomNavBar(),
      ),
    );
  }

  Future<void> initAppData() async {
    SharedPrefs.prefs = await SharedPreferences.getInstance();

    spSearchList.clear();
    spSearchList.add('Products');
    spSearchList.add('Categories');
    spSearchList.add('Locations');
    spSearchList.add('Machines');
    spSearchList.add('Favorites');
    spSearchList.add('Popular');
    spSearchList.add('History');
    spSearchList.add('Scan code');
    selectedFilterVal = spSearchList.elementAt(1);
    setState(() {});
  }

  mainBody(){
    return SingleChildScrollView(
      child: Container(
        width: screenWidth, height: screenHeight,
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: getWindows(),
              )
            ),
            showSearch == true ? Container(
              child: SearchAreaWidget(
                spSearchList: spSearchList,
                selectedFilterVal: selectedSpVal,
                txtController: txtController,
                onClickSearch: (_code){
                  FocusScope.of(context).unfocus();
                  preBottomIndex = bottomIndex;
                  setState(() {
                    searchKey = _code;
                    bottomIndex = 5;
                  });
                },
                onChangedSpinner: (_selectedFilter){
                  setState(() {
                    selectedSpVal = _selectedFilter;
                  });
                },
                onClickQRInput: (){
                  gotoQRInput();
                },
              ),
              padding: EdgeInsets.only(bottom: offsetMSm, top: offsetMSm),
              color: mediumGreyColor,
              height: 66,
            ) :
            Container(),
          ],
        ),
      ),
    );
  }

  bottomNavBar(){
    return BottomAppBar(child: SizedBox(
        height: bottomBarHeight,
        child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              for (var item in mainBottomItems) Expanded(
                child: InkWell(
                  onTap: () {
                    int _bottomIndex = mainBottomItems.indexOf(item);
                    if(_bottomIndex == 5){
                      setState(() {
                        showSearch = !showSearch;
                      });
                    }else{
                      setState(() {
                        bottomIndex = mainBottomItems.indexOf(item);
                      });
                    }
                  },
                  child: Center(
                    child: item['shape'] == 'Circle' ? CircleIconWidget(
                      iconType: item['type'],
                      icon: item['icon'],
                      size: 42.0,
                      color: Colors.white,
                      background: getFocusColor(mainBottomItems.indexOf(item), bottomIndex),
                    ) :
                    IconWidget(
                      iconType: item['type'],
                      icon: item['icon'],
                      size: 42.0,
                      color: getFocusColor(mainBottomItems.indexOf(item), bottomIndex),
                    ),
                  ),
                ),
              ),
            ],
          ),
      ),
      color: Colors.white,
    );
  }

  gotoOtherPages(int index) {
    setState(() {
      bottomIndex = index;
    });
  }

  gotoQRInput() {
    NavigatorService(context).pushToWidget(screen: QrCodeScreen(startFrgIndex: 0, canGoToProductMenu: false, onbackWithCode: (code){
        setState(() {
          txtController.text = code;
        });
      },
      onClickBackHome: (int) {},),
    );
  }
}
