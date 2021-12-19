import 'package:flutter/material.dart';
import 'package:healthensuite/api/network.dart';
import 'package:healthensuite/api/networkmodels/interventionlevels/levelonePODO.dart';
import 'package:healthensuite/api/networkmodels/patientProfilePodo.dart';
import 'package:healthensuite/utilities/constants.dart';
import 'package:healthensuite/utilities/text_data.dart';
import 'package:healthensuite/screens/programs/level1/level1_5.dart';


class Level1of4 extends StatefulWidget {

  static final String title = 'Level 1';
  static final sidePad = EdgeInsets.symmetric(horizontal: 18);
  final InterventionlevelOne levelone;

  final Future<PatientProfilePodo>? patientProfile;

  final int currentPage = 4;
  final int previousPage;

  Level1of4(this.levelone, this.patientProfile, this.previousPage);

  @override
  _Level1of4State createState() => _Level1of4State();
}

class _Level1of4State extends State<Level1of4> {
  String patientName = "Henry";

  @override
  Widget build(BuildContext context) {
    int currentPage = widget.currentPage;
    Future<PatientProfilePodo>? futureprofile = widget.patientProfile;
    InterventionlevelOne level1 = widget.levelone;
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    double pad = 18;

    return Scaffold(
      appBar: AppBar(
        title: Text(Level1of4.title),
        centerTitle: true,
      ),
      bottomNavigationBar: buttomBarWidget(context, level1, futureprofile, currentPage),
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            SizedBox(height: pad,),
            headerWidget(themeData),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: ClampingScrollPhysics(),
                child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     SizedBox(height: pad,),
                     sectionTitleWidget(themeData, text: "How does this program work?", textStyle: themeData.textTheme.headline4),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet10"]!),
                     //SizedBox(height: pad,),
                     topicOutlineDataTable(themeData),
                    //  sectionTitleWidget(themeData, text: LEVEL1_DATA["topic1"], textStyle: themeData.textTheme.headline5),
                    //  sectionTitleWidget(themeData, text: LEVEL1_DATA["topic2"], textStyle: themeData.textTheme.headline5),
                    //  sectionTitleWidget(themeData, text: LEVEL1_DATA["topic3"], textStyle: themeData.textTheme.headline5),
                    //  sectionTitleWidget(themeData, text: LEVEL1_DATA["topic4"], textStyle: themeData.textTheme.headline5),
                    //  sectionTitleWidget(themeData, text: LEVEL1_DATA["topic5"], textStyle: themeData.textTheme.headline5),
                    //  sectionTitleWidget(themeData, text: LEVEL1_DATA["topic6"], textStyle: themeData.textTheme.headline5),
                     //SizedBox(height: pad,),
                     bodyTextWidget(themeData, text: LEVEL1_DATA["bullet11"]!),

                   ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }

  SafeArea buttomBarWidget(BuildContext context, InterventionlevelOne levelone, Future<PatientProfilePodo>? futureProfile, int currentPage) {
    return SafeArea(
      child: BottomAppBar(
        color: Colors.transparent,
        child: Container(
          color: Colors.transparent,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              navIconButton(context, buttonText: "Back", buttonActon: (){
                Navigator.of(context).pop();
              }),

              navIconButton(context, buttonText: "Next", buttonActon: (){
                ApiAccess().savePage(currentPage: currentPage, interventionLevel: 1);
                Navigator.push(
                    context, new MaterialPageRoute(builder: (context) => Level1of5(levelone, futureProfile, currentPage))
                    );
              }),
            ],
          ),
        ),
        elevation: 100,
      ),
    );
  }

  SingleChildScrollView headerWidget(ThemeData themeData) {
    return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                padding: Level1of4.sidePad,
                child: Text('Page 4/7',
                textAlign: TextAlign.left,
                style: themeData.textTheme.bodyText2,),
              ),
              Padding(
                padding: Level1of4.sidePad,
                child: Text('Intro. to Health enSuite Insomnia',
                textAlign: TextAlign.right,
                style: themeData.textTheme.bodyText2,),
              ),

              ],
            ),
          );
  }

  MaterialButton navIconButton(BuildContext context, {required String buttonText, Function? buttonActon}){
    return  MaterialButton(
              child: Text(buttonText, style: TextStyle(color: appItemColorBlue, fontWeight: FontWeight.w700),),
              onPressed: buttonActon as void Function()?,
            );
  }

   Padding sectionTitleWidget(ThemeData themeData, {required String text, TextStyle? textStyle} ) {
     return Padding(
                padding: Level1of4.sidePad,
                child: Text(text,
                  style: textStyle,
                ),
              );
  }

  Padding bodyTextWidget(ThemeData themeData, {required String text}) {
    return Padding(
              padding: Level1of4.sidePad,
              child: Text(text, 
                style: themeData.textTheme.bodyText1,),
            );
  }

  Padding topicOutlineDataTable(ThemeData themeData) {
    return Padding(
            padding: Level1of4.sidePad,
            child: DataTable(
              columns: tableHeaderWidget(themeData),
              rows: [
                rowWidget(themeData, desc: "1", value: LEVEL1_DATA["topic1"]!),
                rowWidget(themeData, desc: "2", value: LEVEL1_DATA["topic2"]!),
                rowWidget(themeData, desc: "3", value: LEVEL1_DATA["topic3"]!),
                rowWidget(themeData, desc: "4", value: LEVEL1_DATA["topic4"]!),
                rowWidget(themeData, desc: "5", value: LEVEL1_DATA["topic5"]!),
                rowWidget(themeData, desc: "6", value: LEVEL1_DATA["topic6"]!),
                
              ],
            )
          );
  }

  List<DataColumn> tableHeaderWidget(ThemeData themeData) {
    return [
              DataColumn(
                label: Text("WEEK", style: themeData.textTheme.headline5,),
                numeric: false
              ),
              DataColumn(
                label: Text("TOPIC", style: themeData.textTheme.headline5,),
                numeric: false
              )
            ];
  }

  DataRow rowWidget(ThemeData themeData, {required String desc, required String value}) {
    return DataRow(
            cells: [
              DataCell(
                Text(desc, style: themeData.textTheme.headline6,),
              ),
              DataCell(
                Text(value, style: themeData.textTheme.headline6,),
              ),
            ]
          );
  }


}