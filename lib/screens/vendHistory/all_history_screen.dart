
import 'package:flutter/material.dart';
import 'package:visualvend/models/vend_history_model.dart';
import 'package:visualvend/utils/colors.dart';
import 'package:visualvend/utils/dimens.dart';
import 'package:visualvend/utils/themes.dart';
import 'package:visualvend/widgets/dropbox_widget.dart';
import 'package:visualvend/widgets/textfield_widget.dart';


class AllVendHistoryScreen extends StatefulWidget {
  final Function(VendHistory) onClickHistory;

  const AllVendHistoryScreen({Key key, this.onClickHistory, }) : super(key: key);

  @override
  _AllVendHistoryScreenState createState() => _AllVendHistoryScreenState();
}

class _AllVendHistoryScreenState extends State<AllVendHistoryScreen> {
  List<String> spVendTitles = new List<String>();
  List<String> spSiteIds = new List<String>();
  var selectedVend, selectedSite;
  int selectedVendIndex = 0;

  TextEditingController txtStartDate = TextEditingController();
  TextEditingController txtEndDate = TextEditingController();

  List<VendHistory> vendHistories = new List<VendHistory>();

  @override
  void initState() {
    super.initState();

    spVendTitles.clear();
    spVendTitles.add('All Vends');
    spVendTitles.add('AusGrid Top Flr');
    spVendTitles.add('Ambos Gnd Flr');
    spVendTitles.add('AMG Hornsby');
    spVendTitles.add('RPA Cent Inst');
    spVendTitles.add('Crown Casino');
    spVendTitles.add('Ambos Lwr Gr Flr');
    spVendTitles.add('AusGrid Top');
    spVendTitles.add('Ambos Gnd');
    spVendTitles.add('AMG Hornsby Flr');
    spVendTitles.add('RPA Cent Instt');
    spVendTitles.add('Crown Casinoo');
    spVendTitles.add('Ambos Lwr Gr');
    selectedVend = 'All Vends';

    spSiteIds.clear();
    spSiteIds.add('All Site IDs');
    for(int i=1; i < 13; i++){
      if(i < 10)
        spSiteIds.add('000' + i.toString());
      else
        spSiteIds.add('00' + i.toString());
    }
    selectedSite = 'All Site IDs';

    vendHistories.clear();
    for(int i = 1; i < 13; i++){
      VendHistory history;
      if(i < 2){
        history = new VendHistory(vendTitle: spVendTitles[i], vendTime: '07/07/2020 04/01/54 PM', vendItem: '01 - \$2.20+0.25c'
            , vendMc: '5217 xxxx xxxx 1499', vendCost: '2.45', vendCc: 'Charged', vendCash: '', vendCH: '');
      }else{
        history = new VendHistory(vendTitle: spVendTitles[i], vendTime: '07/07/2020 04/01/54 PM', vendItem: '01 - \$2.20+0.25c'
            , vendMc: '', vendCost: '2.45', vendCc: 'Charged', vendCash: 'BILLV:1x \$5', vendCH: '1.20 (1x\$1+1x20c)');
      }
      vendHistories.add(history);
    }
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
                  child: Text('Date/Time', style:  semiBold.copyWith(fontSize: fontBase, color: Colors.black),),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 6),
                    child: Text('Item/PayMethod', style:  semiBold.copyWith(fontSize: fontBase, color: Colors.black),),
                  )
                ),
                Container(
                  padding: EdgeInsets.only(left: 6),
                  width: 96,
                  child: Text('Cost/Status', style:  semiBold.copyWith(fontSize: fontBase, color: Colors.black),),
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
                return VendHistoryUI(vendHistories.elementAt(index), index, (eventIndex){
                    widget.onClickHistory(vendHistories.elementAt(eventIndex));
                  }
                );
              },
              itemCount: vendHistories.length,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 6, left: 6, right: 6),
            height: 1, color: Colors.blue.withOpacity(0.7),
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: DropDownWidget(
                    spinnerItems: spVendTitles,
                    selectedText: selectedVend,
                    backColor: lightGreyColor.withOpacity(0.4),
                    onChanged: (val) => {
                      setState((){
                        selectedVend = val;
                      })
                    },
                  ),
                ),
                Expanded(
                  child: Row(
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
          Container(
            padding: EdgeInsets.only(left: 8, right: 8, top: 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'START DATE/TIME',
                    style: semiBold.copyWith(fontSize: fontSm, color: Colors.black.withOpacity(0.7)),
                  ),
                ),
                Expanded(
                  child: Text(
                    'END DATE/TIME',
                    style: semiBold.copyWith(fontSize: fontSm, color: Colors.black.withOpacity(0.7)),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 2, right: 8, top: 4, ),
                    padding: EdgeInsets.only(left: 4),
                    child: NoOutLineTextField(controller: txtStartDate, hint: 'dd/mm/yyyy hh:mm', textSize: fontSm, keyboardType: TextInputType.text,),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.blue.withOpacity(0.7), width: 1
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(offsetXXSm)),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 2, right: 8, top: 4, ),
                    padding: EdgeInsets.only(left: 4),
                    child: NoOutLineTextField(controller: txtEndDate, hint: 'dd/mm/yyyy hh:mm', textSize: fontSm, keyboardType: TextInputType.text,),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.blue.withOpacity(0.7), width: 1
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(offsetXXSm)),
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

