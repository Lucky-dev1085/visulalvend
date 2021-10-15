import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visualvend/models/menu_option_model.dart';
import 'package:visualvend/models/vend_machine_model.dart';
import 'package:visualvend/screens/nearest/all_nearest_screen.dart';
import 'package:visualvend/screens/nearest/view_nearest_screen.dart';
import 'package:visualvend/screens/nearest/view_nearest_set_screen.dart';
import 'package:visualvend/utils/sharedpref.dart';

class NearestVendMachineScreen extends StatefulWidget {
  final Function(int) onClickBackHome;
  NearestVendMachineScreen({Key key, @required this.onClickBackHome}) : super(key: key);

  @override
  _NearestVendMachineScreenState createState() => _NearestVendMachineScreenState();
}

class _NearestVendMachineScreenState extends State<NearestVendMachineScreen> {
  int pageIndex = 0;
  int selectedIndex = 0;
  VendMachine machine;
  List<MenuOptionModel> machineMenus = new List<MenuOptionModel>();

  getWindows(){
    switch(pageIndex){
      case 0:
        return AllNearestScreen(selectedVendIndex: selectedIndex, onClickVendMachine: (_machine, _selectedIndex){
            setState(() {
              machine = _machine;
              selectedIndex = _selectedIndex;
              checkMachineStatus();
            });
          },
          onClickBackHome: (index){
            widget.onClickBackHome(index);
          },
        );
      case 1:
        return ViewNearestSetScreen(machine: machine, onSave: (_savedMenus){
            setState(() {
              machineMenus.clear();
              machineMenus = _savedMenus;
              pageIndex = 2;
            });
          },
        );
      case 2:
        return ViewNearestScreen(machine: machine, machineMenus: machineMenus, resetMenu: (){
            setState(() {
              pageIndex = 1;
            });
          }, onClickMenu: (_machine){
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
      body: getWindows()
    );
  }

  bool checkMachineStatus() {
    machineMenus.clear();
    List<String> titles = <String>[];
    titles.add(SharedPrefs.KEY_VEND_MACHINE_NEARBY);
    titles.add(SharedPrefs.KEY_VEND_MACHINE_BY_LOCATION);
    titles.add(SharedPrefs.KEY_VEND_MACHINE_FULL_LIST);

    for(String _title in titles){
      MenuOptionModel model = SharedPrefs.getMenuOption(_title);
      if(model.title != ''){
        machineMenus.add(model);
      }
    }
    if(machineMenus.length > 0){
      setState(() {
        pageIndex = 2;
      });
    }else{
      setState(() {
        pageIndex = 1;
      });
    }
    return false;
  }
}