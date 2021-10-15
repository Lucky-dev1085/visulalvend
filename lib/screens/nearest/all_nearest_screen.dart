import 'package:flutter/material.dart';
import 'package:visualvend/models/vend_machine_model.dart';
import 'package:visualvend/screens/qrcode/qr_scan_screen.dart';
import 'package:visualvend/services/navigator_service.dart';
import 'package:visualvend/utils/colors.dart';
import 'package:visualvend/utils/constants.dart';
import 'package:visualvend/utils/dimens.dart';
import 'package:visualvend/utils/params.dart';
import 'package:visualvend/utils/themes.dart';
import 'package:visualvend/widgets/dropbox_widget.dart';
import 'package:visualvend/widgets/image_widget.dart';

class AllNearestScreen extends StatefulWidget {
  final int selectedVendIndex;
  final Function(int) onClickBackHome;
  final Function(VendMachine, int) onClickVendMachine;

  const AllNearestScreen({Key key, this.onClickVendMachine, this.selectedVendIndex, this.onClickBackHome, }) : super(key: key);

  @override
  _AllNearestScreenState createState() => _AllNearestScreenState();
}

class _AllNearestScreenState extends State<AllNearestScreen> {
  List<String> spLocations = <String>[];
  List<String> spSiteIds = <String>[];
  var selectedLocation, selectedSite;

  List<VendMachine> vendMachines = <VendMachine>[];

  @override
  void initState() {
    super.initState();

    spLocations.clear();
    spLocations.add('All Locations');
    for(String location in machineLocations){
      spLocations.add(location);
    }
    selectedLocation = 'All Locations';

    spSiteIds.clear();
    spSiteIds.add('All Site IDs');
    for(int i=1; i < 13; i++){
      spSiteIds.add('Site ' + i.toString());
    }
    selectedSite = 'All Site IDs';

    vendMachines.clear();
    for(int i=1; i < 13; i++){
      VendMachine machine = new VendMachine();
      machine.site = spSiteIds[i];
      machine.location = spLocations[i];
      machine.checkStatus = false;
      vendMachines.add(machine);
    }
    vendMachines.elementAt(0).checkStatus = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(offsetBase),
      child: Column(
        children: [
          Container(
            height: 36,
            padding: EdgeInsets.symmetric(horizontal: 6),
            child: Row(
              children: [
                Container(
                  width: 80,
                  child: Text('Site ID', style:  semiBold.copyWith(fontSize: fontBase, color: Colors.black),),
                ),
                Expanded(child: Container(
                  padding: EdgeInsets.only(left: 6),
                  child: Text('Locations', style:  semiBold.copyWith(fontSize: fontBase, color: Colors.black),),
                )
                ),
                Container(
                  width: 96,
                  child: Text('Tick to select', style:  semiBold.copyWith(fontSize: fontBase, color: Colors.black),),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 6, left: 6, right: 6),
            height: 1, color: Colors.blue.withOpacity(0.7),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index){
                return NearbyVendMachineUI(vendMachines.elementAt(index), index, widget.selectedVendIndex, (eventIndex){
                    widget.onClickVendMachine(vendMachines.elementAt(eventIndex), eventIndex);
                  }
                );
              },
              itemCount: vendMachines.length,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 6, left: 6, right: 6),
            height: 1, color: Colors.blue.withOpacity(0.7),
          ),
          SizedBox(height: 8,),
          Container(
            child: Row(
              children: [
                Expanded(child: DropDownWidget(
                  spinnerItems: spLocations,
                  selectedText: selectedLocation,
                  backColor: lightGreyColor.withOpacity(0.4),
                  onChanged: (val) => {
                    setState((){
                        selectedLocation = val;
                      }
                    )
                  },
                ),
                ),
                Expanded(child: Row(
                  children: [
                    Spacer(),
                    DropDownWidget(
                      spinnerItems: spSiteIds,
                      selectedText: selectedSite,
                      backColor: lightGreyColor.withOpacity(0.4),
                      onChanged: (val) => {
                        setState((){
                            selectedSite = val;
                          }
                        )
                      },
                    ),
                  ],
                ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            height: 54.0,
            child: Row(
              children: [
                InkWell(
                  onTap: () => {
                    NavigatorService(context).pushToWidget(screen: QrCodeScreen(startFrgIndex: 3, canGoToProductMenu: true, onClickBackHome: (index){
                      widget.onClickBackHome(index);
                    }, )),
                  },
                  child: IconWidget(
                    icon: 'assets/icons/ic_manul.svg',
                    iconType: ICONTYPE.Svg,
                    size: 42.0,
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () => {
                    NavigatorService(context).pushToWidget(screen: QrCodeScreen(startFrgIndex: 0, canGoToProductMenu: true, onClickBackHome: (index){
                      widget.onClickBackHome(index);
                    },)),
                  },
                  child: Container(
                    width: 120, height: 36,
                    child: Text(
                      'Connect',
                      style: semiBold.copyWith(fontSize: fontMd, color: Colors.black),
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: darkGreyColor, width: 1
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(offsetXSm)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

